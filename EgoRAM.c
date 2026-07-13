/**
 * Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

/*

A0-12  13
D0-7    8
CCTL    1   gpio 21
PHI2    1   gpio 22
RW      1   gpio 23
S4      1   gpio 24
S5      1   gpio 25
    ------
       26
    ======

#define ALL_GPIO_MASK 0x3FFFFFFF
#define ADDR_GPIO_MASK 0x00001FFF
#define DATA_GPIO_MASK 0x001FE000
#define CCTL_GPIO_MASK 0x00200000 // gpio 21
#define PHI2_GPIO_MASK 0x00400000 // gpio 22
#define RW_GPIO_MASK 0x00800000	  // gpio 23
#define S4_GPIO_MASK 0x01000000	  // gpio 24
#define S5_GPIO_MASK 0x02000000	  // gpio 25
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include "pico/stdlib.h"
#include "pico/multicore.h"
#include "pico/rand.h"
#include "hardware/pio.h"
#include "hardware/clocks.h"
#include "hardware/pll.h"
#include "hardware/structs/systick.h"
#include "hardware/vreg.h"
#include "hardware/structs/bus_ctrl.h"
#include "hardware/regs/busctrl.h"

#include "vt100_font_8x8.h"
#include "atari_cart.h"
#include "EgoRAM.h"
#include "cvideo.h"

char c;

int dx_array[EGO_MAX_SPRITES];
int dy_array[EGO_MAX_SPRITES];

static char strbuf[256];

static uint8_t *char_font = (uint8_t *)vt100_font_8x8;
static uint32_t mode;

static volatile uint8_t *video_ram;
// static volatile uint8_t *char_ram;
static volatile uint8_t *cart_d5xx;
static volatile uint32_t ticks;
static bool uart_init_once;

static uint8_t ego_cmd;
static uint32_t ego_state;
static uint32_t ego_shape_no;
static uint32_t ego_sprite_no;
static uint32_t ego_line_no;
static uint32_t ego_charset_no;
static uint32_t ego_cnt;
static uint8_t ego_shape_width;
static uint16_t ego_shape_height;
static uint16_t ego_blitwidth;
static uint16_t ego_blitheight;
static uint16_t ego_line_ptr[256];
static uint16_t ego_addr;
static uint16_t ego_len;
static uint16_t ego_src_ptr;
static uint16_t ego_dst_ptr;
static uint16_t ego_src_inc;
static uint16_t ego_dst_inc;
static uint8_t ego_chr2gfx_width;
static uint8_t ego_chr2gfx_height;
static uint8_t ego_chr2gfx_scroll;
static uint8_t ego_chr2gfx_col38;

static shape_t shape_array[EGO_MAX_SHAPES];
static sprite_t sprite_array[EGO_MAX_SPRITES];
static uint8_t charset_array[2][2048];

static PIO pio = pio0;

static uint8_t fill_front[8] = {
    0x00,
    0x00,
    0xc0,
    0xc0,
    0xf0,
    0xf0,
    0xfc,
    0xfc};

static uint8_t fill_back[8] = {
    0xff,
    0xff,
    0x3f,
    0x3f,
    0x0f,
    0x0f,
    0x03,
    0x03};

static uint8_t manta[] = {
    0x00, 0x00, 0x00, 0x0F, 0xFF, 0x00, 0x3D, 0x57, 0xFF, 0x37, 0xFD, 0xD5, 0xF7, 0xD5, 0x70, 0xDF, 0x7F, 0xFC, 0xDD, 0xFA, 0xBC, 0xDD, 0xEA, 0xEC, 0xD5, 0xFF, 0xAD, 0xFF, 0xEB, 0xAF, 0xD5, 0xEB, 0xFD, 0xFF, 0xEB, 0xAF, 0xD5, 0xFF, 0xAD, 0xDD, 0xEA, 0xEC, 0xDD, 0xFA, 0xBC, 0xDF, 0x7F, 0xFC, 0xF7, 0xD5, 0x70, 0x37, 0xFD, 0xFF, 0x3D, 0x57, 0xD5, 0x0F, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00};

static void systick_init(void)
{
    systick_hw->csr = 0x5;        // Enable + CPU-Clock als Quelle
    systick_hw->rvr = 0x00FFFFFF; // Maximaler Reload-Wert (24-Bit)
}

uint16_t __not_in_flash_func(get_blitwidth)()
{
    return ego_blitwidth;
}

void __not_in_flash_func(set_blitwidth)(uint16_t width)
{
    ego_blitwidth = width;
}

uint16_t __not_in_flash_func(get_blitheight)()
{
    return ego_blitheight;
}

void __not_in_flash_func(set_blitheight)(uint16_t height)
{
    ego_blitheight = height;
}

uint8_t __not_in_flash_func(read_vram)(uint16_t addr)
{
    return video_ram[addr];
}

void __not_in_flash_func(write_vram)(uint16_t addr, uint8_t data)
{
    if (addr >= 0x1fff)
    {
        ego_log("error vram addr: %d\n", addr);
    }
    else
    {
        video_ram[addr] = data;
    }
}

void __not_in_flash_func(sprite_draw)(sprite_t *sp)
{

    int xpos = sp->xpos;
    int ypos = sp->ypos;
    int shape_no = sp->shape_no;

    int width = shape_array[shape_no].width;
    int height = shape_array[shape_no].height;
    int bpp = shape_array[shape_no].bitsperpix;

    int pixx = (xpos << (bpp - 1)) & 0x07;
    int bytex = (xpos >> (4 - bpp));

    int xstart, ystart;
    int xvstart, vstart;
    int xlen, ylen;
    int i, x, y;
    uint8_t mask;
    uint16_t vpos;
    uint8_t *sppos, *mpos;
    uint8_t b, c, m, data;
    bool maskon;

    // ego_log("blitwidth: %d, blitheight %d\n", ego_blitwidth, ego_blitheight);
    // ego_log("sprite_draw: shape_no:%d, x:%d y:%d, width:%d, height: %d, bpp: %d\n", shape_no, xpos, ypos, width, height, bpp);

    if (bytex >= ego_blitwidth + width || ypos > ego_blitheight + height)
    {
        return;
    }

    //
    // compute once the "and" mask for shapes having bitsperpixel == 2
    //
    if (shape_array[shape_no].bitsperpix == 2 && shape_array[shape_no].mask == NULL)
    {
        shape_array[shape_no].mask = malloc(width * height);

        vpos = 0;
        for (y = 0; y < height; y++)
        {
            maskon = false;
            for (x = 0; x < width; x++)
            {
                mask = 0xc0;
                data = shape_array[shape_no].data[vpos];
                shape_array[shape_no].mask[vpos] = 0;

                for (i = 0; i < 4; i++)
                {
                    if (!(data & mask))
                    {
                        shape_array[shape_no].mask[vpos] |= mask;
                        // if (!(data & mask))
                        //   maskon = ~maskon;
                    }
                    mask >>= 2;
                }
                // ego_log("%02X ", shape_array[shape_no].mask[vpos]);
                vpos++;
            }
            // ego_log("\n");
        }
    }

    // vertical start in shape data (top bound)
    ystart = height - ypos;
    if (ystart < 0)
        ystart = 0;

    // vertical number of lines of shape data
    ylen = height - ystart;

    // check bottom bound
    if (ypos >= ego_blitheight + height)
    {
        ylen = ego_blitheight + height - ypos;
    }

    // line of screen RAM
    vstart = ypos - height;
    if (vstart < 0)
        vstart = 0;

    xstart = width - bytex;
    if (xstart < 0)
        xstart = 0;
    xlen = width - xstart;

    xvstart = bytex - width;
    if (xvstart < 0)
        xvstart = 0;

    if (bytex > ego_blitwidth)
        xlen = bytex - ego_blitwidth;

    sppos = &(shape_array[shape_no].data[ystart * width + xstart]);
    mpos = &(shape_array[shape_no].mask[ystart * width + xstart]);

    // ego_log("sprite bytex:%d pixx:%d xstart:%d xlen:%d xvstart:%d ystart:%d ylen:%d vstart:%d mpos: %p sppos: %p\n", bytex, pixx, xstart, xlen, xvstart, ystart, ylen, vstart, mpos, sppos);

    for (y = 0; y < ylen; y++)
    {

        vpos = ego_line_ptr[vstart + y] + xvstart;

        c = 0;
        m = fill_front[pixx];
        if (xstart > 0)
        {
            c = (sppos[-1]) << (8 - pixx);
            m = (mpos[-1]) << (8 - pixx);
        }

        for (x = 0; x < xlen; x++)
        {
            b = read_vram(vpos + x);

            if (sp->mode == EGO_MODE_MASK)
            {
                b &= (m | (mpos[x] >> pixx));
                b |= (c | (sppos[x] >> pixx));
            }
            else
            {
                b ^= (c | (sppos[x] >> pixx));
            }
            write_vram(vpos + x, b);

            c = (sppos[x]) << (8 - pixx);
            m = (mpos[x]) << (8 - pixx);
        }

        if (pixx != 0 && bytex < ego_blitwidth)
        {
            b = read_vram(vpos + x);
            if (sp->mode == EGO_MODE_MASK)
            {
                b &= (m | fill_back[pixx]);
                b |= c;
            }
            else
            {
                b ^= c;
            }
            write_vram(vpos + x, b);
        }

        sppos += width;
        mpos += width;
    }
}

void __not_in_flash_func(render_sprites)(void)
{

    sprite_t *sp;

    for (int i = 0; i < EGO_MAX_SPRITES; i++)
    {
        sp = &sprite_array[i];

        if (sp->enabled)
        {
            // ego_log("calling sprite_draw sprite: %d\n", i);
            sprite_draw(sp);
        }
    }
}

void do_movement()
{
    sprite_t *sp;
    uint16_t xpos, ypos;

    for (int i = 0; i < EGO_MAX_SPRITES; i++)
    {
        sp = &sprite_array[i];

        if (sp->enabled)
        {
            sprite_draw(sp);

            xpos = sp->xpos;
            ypos = sp->ypos;

            xpos += dx_array[i];
            if (xpos >= (ego_blitwidth - shape_array[sp->shape_no].width) << 3 || xpos <= 0)
            {
                dx_array[i] *= -1;
                xpos += dx_array[i];
            }

            ypos += dy_array[i];
            if (ypos >= ego_blitheight || ypos - shape_array[sp->shape_no].height <= 0)
            {
                dy_array[i] *= -1;
                ypos += dy_array[i];
            }

            sp->xpos = xpos;
            sp->ypos = ypos;

            sprite_draw(sp);
        }
    }

    cart_d5xx[EGO_REG_STATUS] &= ~0x80;
}

void __not_in_flash_func(char_to_video)()
{
    int i, x, y;
    int vypos;
    int line;
    uint16_t src_pos;
    uint16_t dst_pos;
    uint8_t b, c;

    src_pos = ego_src_ptr & 0x3fff;
    dst_pos = ego_dst_ptr & 0x3fff;

    // ego_log("char2gfx src:%04X, inc:%04X, dst:%04X, inc:%04X, width:%02X, heigth:%02X, charset:%02X, scroll:%02X\n", src_pos, ego_src_inc, dst_pos, ego_dst_inc, ego_chr2gfx_width, ego_chr2gfx_height, ego_charset_no, ego_chr2gfx_scroll);

    for (y = 0; y < ego_chr2gfx_height; y++)
    {
        for (line = 0; line < 8; line++)
        {
            b = 0;
            for (x = 0; x < ego_chr2gfx_width; x++)
            {
                c = charset_array[ego_charset_no][(video_ram[src_pos + x] << 3) + line];
                if (ego_chr2gfx_col38 != 0 & (x == 0 || x == 39))
                    b = 0;
                else
                    b |= (c >> ego_chr2gfx_scroll);

                video_ram[dst_pos + line * ego_dst_inc + x] = b;
                b = c << (8 - ego_chr2gfx_scroll);
            }
        }
        src_pos += ego_src_inc;
        dst_pos += (ego_dst_inc << 3);
    }
}

void __not_in_flash_func(do_data)(uint8_t data)
{
    int i;
    uint8_t mask;
    bool maskon = false;

    switch (ego_state)
    {
    case EGO_ST_SHAPE_NO:
        ego_shape_no = data;
        ego_state = EGO_ST_SHAPE_WIDTH;
        break;
    case EGO_ST_SHAPE_WIDTH:
        shape_array[ego_shape_no].width = data;
        ego_state = EGO_ST_SHAPE_HEIGHT;
        break;
    case EGO_ST_SHAPE_HEIGHT:
        shape_array[ego_shape_no].height = data;
        if (shape_array[ego_shape_no].data != NULL)
        {
            free(shape_array[ego_shape_no].data);
        }
        if (shape_array[ego_shape_no].mask != NULL)
        {
            free(shape_array[ego_shape_no].mask);
            shape_array[ego_shape_no].mask = NULL;
        }
        shape_array[ego_shape_no].data = malloc(shape_array[ego_shape_no].width * shape_array[ego_shape_no].height);
        // shape_array[ego_shape_no].mask = malloc(shape_array[ego_shape_no].width * shape_array[ego_shape_no].height);
        ego_state = EGO_ST_SHAPE_BPP;
        break;
    case EGO_ST_SHAPE_BPP:
        shape_array[ego_shape_no].bitsperpix = data;
        ego_state = EGO_ST_SHAPE_DATA;
        ego_cnt = 0;
        break;
    case EGO_ST_SHAPE_DATA:
        shape_array[ego_shape_no].data[ego_cnt] = data;

        ego_cnt++;

        if (ego_cnt == shape_array[ego_shape_no].width * shape_array[ego_shape_no].height)
        {
            ego_state = EGO_ST_IDLE;
        }

        break;
    case EGO_ST_SPRITE_NO:
        ego_sprite_no = data;

        if (ego_cmd == EGO_CMD_SET_SPRITE_X || ego_cmd == EGO_CMD_SET_SPRITE_XY)
            ego_state = EGO_ST_SPRITE_X_LO;
        else if (ego_cmd == EGO_CMD_SET_SPRITE_Y)
            ego_state = EGO_ST_SPRITE_Y_LO;
        else if (ego_cmd == EGO_CMD_SPRITE_MODE)
            ego_state = EGO_ST_SPRITE_MODE;
        else
            ego_state = EGO_ST_SPRITE_SHAPE_NO;
        break;
    case EGO_ST_SPRITE_SHAPE_NO:
        sprite_array[ego_sprite_no].shape_no = data;
        ego_state = EGO_ST_IDLE;
        break;
    case EGO_ST_SPRITE_X_LO:
        sprite_array[ego_sprite_no].xold = sprite_array[ego_sprite_no].xpos;
        sprite_array[ego_sprite_no].xpos = data;
        ego_state = EGO_ST_SPRITE_X_HI;
        break;
    case EGO_ST_SPRITE_X_HI:
        sprite_array[ego_sprite_no].xpos |= data << 8;
        if (ego_cmd == EGO_CMD_SET_SPRITE_XY)
            ego_state = EGO_ST_SPRITE_Y_LO;
        else
            ego_state = EGO_ST_IDLE;
        break;
    case EGO_ST_SPRITE_Y_LO:
        sprite_array[ego_sprite_no].yold = sprite_array[ego_sprite_no].ypos;
        sprite_array[ego_sprite_no].ypos = data;
        ego_state = EGO_ST_SPRITE_Y_HI;
        break;
    case EGO_ST_SPRITE_Y_HI:
        sprite_array[ego_sprite_no].ypos |= data << 8;
        ego_state = EGO_ST_IDLE;
        break;
    case EGO_ST_SPRITE_ENA:
        ego_sprite_no = data;
        sprite_array[ego_sprite_no].enabled = true;
        ego_state = EGO_ST_IDLE;
        break;
    case EGO_ST_SPRITE_DIS:
        ego_sprite_no = data;
        sprite_array[ego_sprite_no].enabled = false;
        ego_state = EGO_ST_IDLE;
        break;
    case EGO_ST_BLITWITH:
        ego_blitwidth = data;
        ego_state = EGO_ST_IDLE;
        break;
    case EGO_ST_BLITHEIGHT:
        ego_blitheight = data;
        ego_state = EGO_ST_IDLE;
        break;
    case EGO_ST_LINE_NO:
        ego_line_no = data;
        ego_cnt = 0;
        ego_state = EGO_ST_LINE_DATA_LO;
        break;
    case EGO_ST_LINE_DATA_LO:
        ego_line_ptr[ego_cnt] = data;
        ego_state = EGO_ST_LINE_DATA_HI;
        break;
    case EGO_ST_LINE_DATA_HI:
        ego_line_ptr[ego_cnt++] |= (data & 0x1f) << 8;
        if (ego_cnt >= ego_line_no)
        {
            ego_state = EGO_ST_IDLE;
            ego_log("cnt:%d %04X\n", ego_cnt, ego_line_ptr[ego_cnt - 1]);
        }
        else
            ego_state = EGO_ST_LINE_DATA_LO;
        break;
    case EGO_ST_FILL_MEM_LO:
        ego_addr = data;
        ego_state = EGO_ST_FILL_MEM_HI;
        break;
    case EGO_ST_FILL_MEM_HI:
        ego_addr |= (data & 0x3f) << 8;
        ego_state = EGO_ST_FILL_LEN_LO;
        break;
    case EGO_ST_FILL_LEN_LO:
        ego_len = data;
        ego_state = EGO_ST_FILL_LEN_HI;
        break;
    case EGO_ST_FILL_LEN_HI:
        ego_len |= data << 8;
        ego_state = EGO_ST_FILL_BYTE;
        break;
    case EGO_ST_FILL_BYTE:
        if (ego_addr + ego_len > 0x3fff)
        {
            ego_len = 0x3fff - ego_addr;
        }
        memset((void *)&video_ram[ego_addr], data, ego_len);
        ego_state = EGO_ST_IDLE;
        break;
    case EGO_ST_SPRITE_MODE:
        sprite_array[ego_sprite_no].mode = data;
        ego_state = EGO_ST_IDLE;
        break;
    case EGO_ST_CHARSET_NO:
        ego_charset_no = data & 0x01;
        ego_state = EGO_ST_CHARSET_DATA;
        ego_cnt = 0;
        break;
    case EGO_ST_CHARSET_DATA:
        charset_array[ego_charset_no][ego_cnt] = data;
        ego_cnt++;
        if (ego_cnt >= 2048)
        {
            ego_state = EGO_ST_IDLE;
            ego_log("charset %d loaded\n", ego_charset_no);
        }
        break;
    case EGO_ST_CHR2GFX_SRC_LO:
        ego_src_ptr = data;
        ego_state = EGO_ST_CHR2GFX_SRC_HI;
        break;
    case EGO_ST_CHR2GFX_SRC_HI:
        ego_src_ptr |= data << 8;
        ego_state = EGO_ST_CHR2GFX_SRC_INC_LO;
        break;
    case EGO_ST_CHR2GFX_SRC_INC_LO:
        ego_src_inc = data;
        ego_state = EGO_ST_CHR2GFX_SRC_INC_HI;
        break;
    case EGO_ST_CHR2GFX_SRC_INC_HI:
        ego_src_inc |= data << 8;
        ego_state = EGO_ST_CHR2GFX_DST_LO;
        break;
    case EGO_ST_CHR2GFX_DST_LO:
        ego_dst_ptr = data;
        ego_state = EGO_ST_CHR2GFX_DST_HI;
        break;
    case EGO_ST_CHR2GFX_DST_HI:
        ego_dst_ptr |= data << 8;
        ego_state = EGO_ST_CHR2GFX_DST_INC_LO;
        break;
    case EGO_ST_CHR2GFX_DST_INC_LO:
        ego_dst_inc = data;
        ego_state = EGO_ST_CHR2GFX_DST_INC_HI;
        break;
    case EGO_ST_CHR2GFX_DST_INC_HI:
        ego_dst_inc |= data << 8;
        ego_state = EGO_ST_CHR2GFX_WIDTH;
        break;
    case EGO_ST_CHR2GFX_WIDTH:
        ego_chr2gfx_width = data;
        ego_state = EGO_ST_CHR2GFX_HEIGHT;
        break;
    case EGO_ST_CHR2GFX_HEIGHT:
        ego_chr2gfx_height = data;
        ego_state = EGO_ST_CHR2GFX_CHARSET_NO;
        break;
    case EGO_ST_CHR2GFX_CHARSET_NO:
        ego_charset_no = data & 0x01;
        ego_state = EGO_ST_CHR2GFX_SCROLL;
        break;
    case EGO_ST_CHR2GFX_SCROLL:
        ego_chr2gfx_scroll = data & 0x07;
        ego_state = EGO_ST_CHR2GFX_COL38;
        break;
    case EGO_ST_CHR2GFX_COL38:
        ego_chr2gfx_col38 = data;
        ego_state = EGO_ST_IDLE;
        char_to_video();
        break;
    default:
        break;
    }
}

void __not_in_flash_func(do_command)(uint8_t data)
{
    ego_cmd = data;

    switch (ego_cmd)
    {
    case EGO_CMD_RENDER_SPRITES:
        render_sprites();
        break;
    case EGO_CMD_SET_WRITEABLE:
        set_writeable(true);
        cart_d5xx[EGO_REG_STATUS] |= 0x01;
        break;
    case EGO_CMD_SET_READONLY:
        set_writeable(false);
        cart_d5xx[EGO_REG_STATUS] &= ~0x01;
        break;
    case EGO_CMD_ABORT:
        ego_state = EGO_ST_IDLE;
        break;
    case EGO_CMD_SHAPE_DATA:
        ego_state = EGO_ST_SHAPE_NO;
        break;
    case EGO_CMD_DEL_SHAPE:
        break;
    case EGO_CMD_SPRITE_DATA:
        ego_state = EGO_ST_SPRITE_NO;
        break;
    case EGO_CMD_DEL_SPRITE:
        break;
    case EGO_CMD_ENA_SPRITE:
        ego_state = EGO_ST_SPRITE_ENA;
        break;
    case EGO_CMD_DIS_SPRITE:
        ego_state = EGO_ST_SPRITE_DIS;
        break;
    case EGO_CMD_SET_SPRITE_X:
        ego_state = EGO_ST_SPRITE_NO;
        break;
    case EGO_CMD_SET_SPRITE_Y:
        ego_state = EGO_ST_SPRITE_NO;
        break;
    case EGO_CMD_SET_SPRITE_XY:
        ego_state = EGO_ST_SPRITE_NO;
        break;
    case EGO_CMD_SET_BLIT_WIDTH:
        ego_state = EGO_ST_BLITWITH;
        break;
    case EGO_CMD_SET_BLIT_HEIGHT:
        ego_state = EGO_ST_BLITHEIGHT;
        break;
    case EGO_CMD_LINE_PTR:
        ego_state = EGO_ST_LINE_NO;
        break;
    case EGO_CMD_FILL_MEM:
        ego_state = EGO_ST_FILL_MEM_LO;
        break;
    case EGO_CMD_SPRITE_MODE:
        ego_state = EGO_ST_SPRITE_NO;
        break;
    case EGO_CMD_CHARSET:
        ego_state = EGO_ST_CHARSET_NO;
        break;
    case EGO_CMD_CHAR_TO_VIDEO:
        ego_state = EGO_ST_CHR2GFX_SRC_LO;
        break;
    case EGO_CMD_MOVEMENT:
        do_movement();
        break;
    default:
        break;
    }
}

void __not_in_flash_func(core1_main)()
{
    uint32_t msg;
    uint32_t data;
    uint32_t addr;

    systick_init();

    ego_log("core1 started...\n");

    while (true)
    {
        msg = multicore_fifo_pop_blocking();

        ticks = systick_hw->cvr;

        addr = msg & 0xff;
        data = msg >> 16;

        switch (addr)
        {
        case EGO_REG_CMD:
            do_command(data);
            /*
            if (data == EGO_CMD_RENDER_SPRITES)
            {
                ticks = (ticks - systick_hw->cvr) & 0xffffff;
                ego_log("addr: %04X, data: %02X, ticks: %d\n", msg & 0xffff, msg >> 16, ticks);
            }
            */
            break;
        case EGO_REG_DATA:
            do_data(data);
            break;
        default:
            break;
        }

        cart_d5xx[EGO_REG_STATUS] &= ~0x80;
    }
}

void __not_in_flash_func(putChar)(int xpos, int ypos, uint8_t c)
{
    // ego_log("%p %02X ", (ypos * ego_blitwidth * 8) + xpos, c);

    uint8_t volatile *pscreen = &video_ram[(ypos * ego_blitwidth * 8) + xpos];
    uint8_t *pchar = &char_font[c << 3];

    for (int i = 0; i < 8; i++)
    {
        *pscreen = *pchar;
        pchar++;
        pscreen += ego_blitwidth;
    }
}

uint8_t read_d5xx(uint8_t addr)
{
    return cart_d5xx[addr];
}

void __not_in_flash_func(write_d5xx)(uint8_t addr, uint8_t data)
{

    cart_d5xx[EGO_REG_STATUS] |= 0x80;

    if (multicore_fifo_wready)
    {
        multicore_fifo_push_blocking(addr | (data << 16));
    }
    else
    {
        ego_log("write to FiFo failed\n");
    }
}

void __not_in_flash_func(ego_log)(const char *format, ...)
{

    va_list args;

    va_start(args, format);
    vsnprintf(strbuf, sizeof(strbuf), format, args);
    va_end(args);

    if (mode == EGO_MODE_USB)
    {
        while (!stdio_usb_connected())
        {
            sleep_ms(100);
        }

        printf("%s", strbuf);
    }
    else
    {
        if (!uart_init_once)
        {
            uart_init_once = true;
            uart_init(EGO_UART_ID, EGO_BAUD_RATE);
            gpio_set_function(EGO_UART_TX_PIN, GPIO_FUNC_UART);
            gpio_set_function(EGO_UART_RX_PIN, GPIO_FUNC_UART);
        }

        uart_puts(EGO_UART_ID, strbuf);
    }
}

void test()
{
    int width = 40;
    int height = 200;
    uint16_t xpos = 20;
    uint16_t ypos = 20;

    int x, y, c;
    uint16_t ptr = 0;

    write_d5xx(EGO_REG_CMD, EGO_CMD_SET_BLIT_WIDTH);
    write_d5xx(EGO_REG_DATA, (uint8_t)width);
    write_d5xx(EGO_REG_CMD, EGO_CMD_SET_BLIT_HEIGHT);
    write_d5xx(EGO_REG_DATA, (uint8_t)height);

    write_d5xx(EGO_REG_CMD, EGO_CMD_LINE_PTR);
    write_d5xx(EGO_REG_DATA, 200);
    for (x = 0; x < 200; x++)
    {
        write_d5xx(EGO_REG_DATA, ptr & 0xff);
        write_d5xx(EGO_REG_DATA, ptr >> 8);
        ptr += width;
    }

    for (x = 0; x < EGO_MAX_SPRITES; x++)
    {
        dx_array[x] = 1;
        if (get_rand_32() & 0x01)
            dx_array[x] *= -1;

        dy_array[x] = 1;
        if (get_rand_32() & 0x01)
            dy_array[x] *= -1;
    }

    c = 0;
    for (y = 0; y < (height >> 3); y++)
    {
        for (x = 0; x < width; x++)
        {
            putChar(x, y, c);
            // c++;
        }
    }

    write_d5xx(EGO_REG_CMD, EGO_CMD_SPRITE_MODE);
    write_d5xx(EGO_REG_DATA, x); // sprite number
    write_d5xx(EGO_REG_DATA, 1); // sprite number

    write_d5xx(EGO_REG_CMD, EGO_CMD_SHAPE_DATA);
    write_d5xx(EGO_REG_DATA, 0x00); // shape number
    write_d5xx(EGO_REG_DATA, 3);    // shape width
    write_d5xx(EGO_REG_DATA, 21);   // shape height
    write_d5xx(EGO_REG_DATA, 2);    // shape bpp

    for (y = 0; y < 21; y++)
    {
        for (x = 0; x < 3; x++)
        {
            write_d5xx(EGO_REG_DATA, manta[y * 3 + x]);
        }
    }

    /*
        write_d5xx(EGO_REG_DATA, 0xff); // shape data
        write_d5xx(EGO_REG_DATA, 0xff); // shape data
        write_d5xx(EGO_REG_DATA, 0xff); // shape data
        write_d5xx(EGO_REG_DATA, 0xff); // shape data
        write_d5xx(EGO_REG_DATA, 0xff); // shape data
        write_d5xx(EGO_REG_DATA, 0xff); // shape data
        write_d5xx(EGO_REG_DATA, 0xff); // shape data
        write_d5xx(EGO_REG_DATA, 0xff); // shape data
        write_d5xx(EGO_REG_DATA, 0xff); // shape data
        write_d5xx(EGO_REG_DATA, 0xff); // shape data
        write_d5xx(EGO_REG_DATA, 0xff); // shape data
        write_d5xx(EGO_REG_DATA, 0xff); // shape data
        write_d5xx(EGO_REG_DATA, 0xff); // shape data
        write_d5xx(EGO_REG_DATA, 0xff); // shape data
        write_d5xx(EGO_REG_DATA, 0xff); // shape data
        write_d5xx(EGO_REG_DATA, 0xff); // shape data
    */

    for (x = 0; x < EGO_MAX_SPRITES; x++)
    {
        write_d5xx(EGO_REG_CMD, EGO_CMD_SPRITE_DATA);
        write_d5xx(EGO_REG_DATA, x);    // sprite number
        write_d5xx(EGO_REG_DATA, 0x00); // shape number

        write_d5xx(EGO_REG_CMD, EGO_CMD_SET_SPRITE_XY);
        write_d5xx(EGO_REG_DATA, x);                            // sprite number
        write_d5xx(EGO_REG_DATA, get_rand_32() % (width << 3)); // sprite X lo
        write_d5xx(EGO_REG_DATA, 0);                            // sprite X hi
        // write_d5xx(EGO_REG_DATA, xpos & 0xff);                  // sprite X lo
        // write_d5xx(EGO_REG_DATA, xpos >> 8);                    // sprite X hi
        write_d5xx(EGO_REG_DATA, get_rand_32() % height); // sprite Y lo
        write_d5xx(EGO_REG_DATA, 0);                      // sprite Y hi
        // write_d5xx(EGO_REG_DATA, ypos & 0xff);                  // sprite Y lo
        // write_d5xx(EGO_REG_DATA, ypos >> 8);                    // sprite Y hi

        write_d5xx(EGO_REG_CMD, EGO_CMD_ENA_SPRITE);
        write_d5xx(EGO_REG_DATA, x); // sprite number

        write_d5xx(EGO_REG_CMD, EGO_CMD_SPRITE_MODE);
        write_d5xx(EGO_REG_DATA, x); // sprite number
        write_d5xx(EGO_REG_DATA, 1); // sprite number
    }

    write_d5xx(EGO_REG_CMD, EGO_CMD_RENDER_SPRITES);

    while (true)
    {
        c = getchar();
        printf("%c", c);

        write_d5xx(EGO_REG_CMD, EGO_CMD_RENDER_SPRITES);
        while (read_d5xx(EGO_REG_STATUS & 0x80))
            ;

        switch (c)
        {
        case 's':
            ypos--;
            break;
        case 'x':
            ypos++;
            break;
        case 'a':
            xpos--;
            break;
        case 'd':
            xpos++;
            break;
        default:
            break;
        }

        write_d5xx(EGO_REG_CMD, EGO_CMD_SET_SPRITE_XY);
        write_d5xx(EGO_REG_DATA, 0);
        write_d5xx(EGO_REG_DATA, xpos & 0xff);
        write_d5xx(EGO_REG_DATA, xpos >> 8);
        write_d5xx(EGO_REG_DATA, ypos & 0xff);
        write_d5xx(EGO_REG_DATA, ypos >> 8);

        write_d5xx(EGO_REG_CMD, EGO_CMD_RENDER_SPRITES);
        while (read_d5xx(EGO_REG_STATUS & 0x80))
            ;
    }
}

void set_core0_highest_bus_priority()
{
    // Setzt die Bus-Priorität für Kern 0 auf hoch (1) und Kern 1 auf niedrig (0)
    bus_ctrl_hw->priority = BUSCTRL_BUS_PRIORITY_PROC0_BITS;
}

int main()
{
    vreg_set_voltage(VREG_VOLTAGE_1_20);
    sleep_ms(10);
    set_sys_clock_khz(250000, true);
    sleep_ms(10);
    systick_init();

    stdio_init_all();

    // check to see if we are plugged into Atari 8-bit
    // by checking for high on PHI2 gpio for xxx ms
    gpio_init(ATARI_PHI2_PIN);
    gpio_set_dir(ATARI_PHI2_PIN, GPIO_IN);

    uart_init_once = false;
    mode = EGO_MODE_USB;

    while (to_ms_since_boot(get_absolute_time()) < 100)
    {
        if (!gpio_get(ATARI_PHI2_PIN))
        {
            mode = EGO_MODE_ATARI;
        }
    }

    video_ram = get_cart_ram();
    //   char_ram = video_ram + 0x3800;
    cart_d5xx = get_cart_d5xx();

    // memset((void *)video_ram, 0x01, 4 * 1024);
    // memset((void *)video_ram + 0x1000, 0x10, 4 * 1024);
    memset((void *)video_ram + 0x2000, 0xaa, 8 * 1024);

    memset((void *)sprite_array, 0x00, sizeof(sprite_array));
    memset((void *)shape_array, 0x00, sizeof(shape_array));

    ego_log("\033[2J\033[HEgoRAM starting...\n");
    if (mode == EGO_MODE_USB)
        ego_log("mode: USB\n");
    else
        ego_log("mode: ATARI\n");

    ego_log("sys_clock: %d\n", clock_get_hz(clk_sys));
    ego_log("video_ram at %p\n", video_ram);
    ego_log("cart_d5xx at %p\n", cart_d5xx);

    for (int x = 0; x < EGO_MAX_SPRITES; x++)
    {
        dx_array[x] = 1;
        if (get_rand_32() & 0x01)
            dx_array[x] *= -1;

        dy_array[x] = 1;
        if (get_rand_32() & 0x01)
            dy_array[x] *= -1;
    }

    multicore_launch_core1(core1_main);

    if (mode == EGO_MODE_ATARI)
    {
        // irq_set_enabled(USBCTRL_IRQ, false);
        uint32_t status = save_and_disable_interrupts();
        set_core0_highest_bus_priority();
        atari_cart_main();
    }

    initialise_cvideo(pio0);

    test();
}
