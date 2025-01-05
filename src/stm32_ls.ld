ENTRY(Reset_Handler)

MEMORY
{
	FLASH(rx):ORIGIN =0x08000000,LENGTH =1024K
	SRAM(rwx):ORIGIN =0x20000000,LENGTH =128K
}

SECTIONS
{
	.text :
	{
		/* merge .text of 	001led_toggle.o  	stm32f407xx_gpio_driver.o	  startup_stm32f407vgtx.o */
		/* must put vector table first in FLASH memory */
		
		*(.Vector_table)
		*(.text)
		*(.text.*)
		*(.init)
		*(.fini)
		*(.rodata)
		*(.rodata.*)
		. = ALIGN(4);
		_etext = .;
	}> FLASH

	/* LOADADDR(section) = standard function in linker script that returns the absolute LMA of the named section */
	_load_addr_data = LOADADDR(.data);

	.data :
	{
		_sdata = .;
		*(.data)
		*(.data.*)
		. = ALIGN(4);
		_edata = .;
	}> SRAM AT> FLASH

	.bss :
	{
		_sbss = .;
		__bss_start__ = _sbss;
		*(.bss)
		*(.bss.*)
		*(COMMON)
		. = ALIGN(4);
		_ebss = .;
		__bss_end__ = _ebss;
		. = ALIGN(4);
		end = .;				/* Symbol needed for system call implementations in our own syscalls.c source file */
		__end__ = .; 			/* Symbol needed for system call implementations in semihosting library */
	}> SRAM
}