/*
 * 001led_toggle.c
 *
 *  Created on: Mar 18, 2024
 *      Author: butle
 */

#include "stm32f407xx.h"
#include <stdio.h>

const uint32_t pi = 3;
const uint8_t small_var = 1;
uint32_t radius = 2;
uint32_t diameter;

extern void initialise_monitor_handles(void); //Semihosting init function

void delay(void);

int main(void)
{
	initialise_monitor_handles(); 

	diameter = radius * 2;
	uint32_t area = pi * radius * radius;
	uint32_t circumference = pi * diameter;
	(void) area;
	(void) circumference;

	GPIO_Handle_t GpioLed;

	GpioLed.pGPIOx = GPIOD;
	GpioLed.GPIO_PinConfig.GPIO_PinNumber = GPIO_PIN_NO_12;
	GpioLed.GPIO_PinConfig.GPIO_PinMode = GPIO_MODE_OUT;
	GpioLed.GPIO_PinConfig.GPIO_PinSpeed = GPOI_SPEED_HIGH;
	GpioLed.GPIO_PinConfig.GPIO_PinOPType = GPIO_OP_TYPE_PP;
	GpioLed.GPIO_PinConfig.GPIO_PinPuPdControl = GPIO_NO_PUPD;

	GPIO_PeriClockControl(GPIOD, ENABLE);
	GPIO_Init(&GpioLed);

	while(1)
	{
		GPIO_ToggleOutputPin(GPIOD, 12);
		printf("LED toggled\n");
		delay();
	}

}

void delay(void)
{
	for(uint32_t t = 0; t < 200000 ; t++);
}
