#define EGO_MAX_SPRITES 64
#define EGO_MAX_SHAPES 64

#define EGO_MODE_ATARI 0
#define EGO_MODE_USB 1

#define EGO_UART_ID uart0
#define EGO_BAUD_RATE 115200
#define EGO_UART_TX_PIN 28
#define EGO_UART_RX_PIN 29

#define EGO_REG_CMD 0
#define EGO_REG_STATUS 1
#define EGO_REG_DATA 2

#define EGO_CMD_RENDER_SPRITES 0
#define EGO_CMD_SET_WRITEABLE 1
#define EGO_CMD_SET_READONLY 2
#define EGO_CMD_ABORT 3
#define EGO_CMD_SHAPE_DATA 4
#define EGO_CMD_DEL_SHAPE 5
#define EGO_CMD_SPRITE_DATA 6
#define EGO_CMD_DEL_SPRITE 7
#define EGO_CMD_ENA_SPRITE 8
#define EGO_CMD_DIS_SPRITE 9
#define EGO_CMD_SET_SPRITE_X 10
#define EGO_CMD_SET_SPRITE_Y 11
#define EGO_CMD_SET_SPRITE_XY 12
#define EGO_CMD_SET_BLIT_WIDTH 13
#define EGO_CMD_SET_BLIT_HEIGHT 14
#define EGO_CMD_LINE_PTR 15
#define EGO_CMD_FILL_MEM 16
#define EGO_CMD_SPRITE_MODE 17
#define EGO_CMD_CHARSET 18
#define EGO_CMD_CHAR_TO_VIDEO 19
#define EGO_CMD_MOVEMENT 99

#define EGO_ST_IDLE 0
#define EGO_ST_SHAPE_NO 1
#define EGO_ST_SHAPE_WIDTH 2
#define EGO_ST_SHAPE_HEIGHT 3
#define EGO_ST_SHAPE_BPP 4
#define EGO_ST_SHAPE_DATA 5
#define EGO_ST_SPRITE_NO 6
#define EGO_ST_SPRITE_SHAPE_NO 7
#define EGO_ST_SPRITE_X_LO 8
#define EGO_ST_SPRITE_X_HI 9
#define EGO_ST_SPRITE_Y_LO 10
#define EGO_ST_SPRITE_Y_HI 11
#define EGO_ST_SPRITE_ENA 12
#define EGO_ST_SPRITE_DIS 13
#define EGO_ST_BLITWITH 14
#define EGO_ST_BLITHEIGHT 15
#define EGO_ST_LINE_NO 16
#define EGO_ST_LINE_DATA_LO 17
#define EGO_ST_LINE_DATA_HI 18
#define EGO_ST_FILL_MEM_LO 19
#define EGO_ST_FILL_MEM_HI 20
#define EGO_ST_FILL_LEN_LO 21
#define EGO_ST_FILL_LEN_HI 22
#define EGO_ST_FILL_BYTE 23
#define EGO_ST_SPRITE_MODE 24
#define EGO_ST_CHARSET_NO 25
#define EGO_ST_CHARSET_DATA 26
#define EGO_ST_CHR2GFX_SRC_LO 27
#define EGO_ST_CHR2GFX_SRC_HI 28
#define EGO_ST_CHR2GFX_SRC_INC_LO 29
#define EGO_ST_CHR2GFX_SRC_INC_HI 30
#define EGO_ST_CHR2GFX_DST_LO 31
#define EGO_ST_CHR2GFX_DST_HI 32
#define EGO_ST_CHR2GFX_DST_INC_LO 33
#define EGO_ST_CHR2GFX_DST_INC_HI 34
#define EGO_ST_CHR2GFX_WIDTH 35
#define EGO_ST_CHR2GFX_HEIGHT 36
#define EGO_ST_CHR2GFX_CHARSET_NO 37

#define EGO_MODE_XOR 0
#define EGO_MODE_MASK 1

/*
Sprite data:
b00		logical sprite number
b01		width in bytes
b02		height in lines
bxx.yy	width*heigt data
*/

typedef struct
{
	uint8_t width;
	uint8_t height;
	uint8_t bitsperpix;
	uint8_t *data;
	uint8_t *mask;
} shape_t;

typedef struct
{
	uint8_t enabled;
	uint8_t mode;
	uint16_t xpos;
	uint16_t ypos;
	uint8_t shape_no;
	uint16_t xold;
	uint16_t yold;
} sprite_t;

void set_blitwidth(uint16_t width);
void set_blitheight(uint16_t heigth);

uint16_t get_blitwidth();
uint16_t get_blitheight();

void sprite_draw_all();
void sprite_draw(sprite_t *sp);
void write_d5xx(uint8_t addr, uint8_t data);
uint8_t read_d5xx(uint8_t addr);
void ego_log(const char *format, ...);
