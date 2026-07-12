/**
 *    _   ___ ___ _       ___          _
 *   /_\ ( _ ) _ (_)__ _ / __|__ _ _ _| |_
 *  / _ \/ _ \  _/ / _/_\ (__/ _` | '_|  _|
 * /_/ \_\___/_| |_\__\_/\___\__,_|_|  \__|
 *
 *
 * Atari 8-bit cartridge for Raspberry Pi Pico
 *
 * Robin Edwards 2023
 *
 * Needs to be a release NOT debug build for the cartridge emulation to work
 *
 * Changes from UnoCart:
 * - Attempts to get S4/S5, RD4/RD5 MMU behaviour correct on 400/800
 *   https://forums.atariage.com/topic/241888-ultimate-cart-sd-multicart-technical-thread/page/10/#comment-4266797
 * - Adds 4k carts (CAR type 58)
 * - Adds Turbsoft carts (CAR types 50,51)
 * - Adds ATRAX 128k carts (CAR type 17)
 * - Adds Microcalc/Utracart (CAR type 52)
 * - Adds Standard 2k cars (CAR type 57)
 * - Adds Phoenix 8k cars (CAR type 39)
 * - Adds Blizzard 4k cars (CAR type 46)
 */

#include <string.h>
#include <stdlib.h>
#include "pico/multicore.h"

#include "pico/stdlib.h"
#include "hardware/sync.h"
#include "hardware/clocks.h"
#include "EgoRAM.h"

#define ALL_GPIO_MASK 0x3FFFFFFF
#define ADDR_GPIO_MASK 0x00001FFF
#define DATA_GPIO_MASK 0x001FE000
#define CCTL_GPIO_MASK 0x00200000 // gpio 21
#define PHI2_GPIO_MASK 0x00400000 // gpio 22
#define RW_GPIO_MASK 0x00800000	  // gpio 23
#define S4_GPIO_MASK 0x01000000	  // gpio 24
#define S5_GPIO_MASK 0x02000000	  // gpio 25

#define S4_S5_GPIO_MASK 0x03000000
#define CCTL_RW_GPIO_MASK 0x00A00000

#define RD4_PIN 26
#define RD5_PIN 27

#define RD4_LOW gpio_put(RD4_PIN, 0)
#define RD4_HIGH gpio_put(RD4_PIN, 1)
#define RD5_LOW gpio_put(RD5_PIN, 0)
#define RD5_HIGH gpio_put(RD5_PIN, 1)
#define SET_DATA_MODE_OUT gpio_set_dir_out_masked(DATA_GPIO_MASK)
#define SET_DATA_MODE_IN gpio_set_dir_in_masked(DATA_GPIO_MASK)

// #include "rom.h"
// #include "osrom.h"

static volatile unsigned char cart_ram[16 * 1024];
static volatile unsigned char cart_d5xx[256];
static volatile bool writeable = true;

volatile unsigned char *__not_in_flash_func(get_cart_d5xx)()
{
	return cart_d5xx;
}

volatile unsigned char *__not_in_flash_func(get_cart_ram)()
{
	return cart_ram;
}

void __not_in_flash_func(emulate_roland)()
{
	// 8k
	RD4_HIGH;
	RD5_HIGH;

	uint8_t data;
	uint32_t pins;
	uint16_t addr;
	volatile uint8_t *ram_ptr;

	while (1)
	{
		// wait for phi2 high
		while (!((pins = gpio_get_all()) & PHI2_GPIO_MASK))
			;

		addr = pins & ADDR_GPIO_MASK;

		ram_ptr = NULL;
		if ((pins & S4_GPIO_MASK) == 0)
			ram_ptr = cart_ram;
		// ram_ptr = NULL;
		else if ((pins & S5_GPIO_MASK) == 0)
			ram_ptr = &cart_ram[0x2000];
		// ram_ptr = cart_ram;
		else if ((pins & CCTL_GPIO_MASK) == 0)
			ram_ptr = cart_d5xx;

		if (ram_ptr != NULL)
		{
			if (!(pins & RW_GPIO_MASK))
			{
				// ATARI writes to datat bus
				// read data bus on falling edge of phi2
				while ((pins = gpio_get_all()) & PHI2_GPIO_MASK)
					;
				data = (pins & DATA_GPIO_MASK) >> 13;

				if (ram_ptr == cart_d5xx)
				{
					write_d5xx(addr, data);
				}
				else if (writeable)
				{
					ram_ptr[addr] = data;
				}
			}
			else
			{
				// read
				SET_DATA_MODE_OUT;
				if (ram_ptr == cart_d5xx)
				{
					addr &= 0xff;
				}
				gpio_put_masked(DATA_GPIO_MASK, ((uint32_t)ram_ptr[addr]) << 13);

				//  wait for phi2 low
				while (gpio_get_all() & PHI2_GPIO_MASK)
					;
				SET_DATA_MODE_IN;
			}
		}
	}
}

void set_writeable(bool truefalse)
{
	writeable = truefalse;
}

#define ATARI_PHI2_PIN 22 // used on boot to check if we are plugged into an atari or usb

void __not_in_flash_func(atari_cart_main)()
{
	gpio_init_mask(0x0FFFFFFF);

	gpio_set_dir_in_masked(ADDR_GPIO_MASK | DATA_GPIO_MASK | CCTL_GPIO_MASK | PHI2_GPIO_MASK | RW_GPIO_MASK | S4_GPIO_MASK | S5_GPIO_MASK);
	gpio_set_dir(RD4_PIN, GPIO_OUT);
	gpio_set_dir(RD5_PIN, GPIO_OUT);

	emulate_roland();
}
