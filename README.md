# STR32-Programming-within-WSL-Ubuntu-Test
Testing out arm-gcc build toolchain, OpenOCD programming and gdb debugging from scratch using WSL2 (Ubuntu 24.04) in x86-64 Windows 11 host machine environment

----- Installing usbipd for USB device visibility within WSL -----

Important: WSL2 does not natively support the recognizing of USB devices connected to the host Windows 11 machine. In order to get this working, there is some WSL configuration you need to do:
Useful guides here: 
  - https://learn.microsoft.com/en-us/windows/wsl/connect-usb#install-the-usbip-tools-and-hardware-database-in-linux
  - https://hackmd.io/@aeefs2Y8TMms-cjTDX4cfw/r1fqAa_Da#My-setup

	- Installs usbipd in windows host
	- Attaches desired usb devices to wsl2 so that ubuntu subsystem can access it
	- Sets up permissions in ubuntu for usb debugging as ,$USER> user, not just root
		- "Ensure that the device is accesible by plugdev group and also the read, write permissions"
    		- Use 'ls -l /dev/bus/usb/<Bus>/<Device>' where bus and device can be obtained by using lsusb command in ubuntu


Now, the device should be accessible to wsl2 applications

NOTE: YOU WILL HAVE TO RERUN "usbipd attach --wsl --busid <BUSID>" IN WINDOWS 11 SHELL EVERYTIME YOU PHYSICALLY DISCONNECT THE STM32


----- Installing GCC for ARM cross-compiler on WSL2 -----

1. Go to https://developer.arm.com/downloads/-/gnu-rm
2. Download Linux x86_64 Tarball on Windows side
3. Copy the tar file from windows mnt to my user directory (NOT root directory) within wsl using mounted windows drive
4. Use "tar -xvf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2" to extract and download cross compiler
5. Add the cross-compile "arm-none-eabi-gcc" command to the Linux command search path with:
	"export PATH=$PATH:~/gcc-arm-none-eabi-10.3-2021.10/bin"
6. Make sure everything went well and the executable cross-compiler is working:
	:~$       arm-none-eabi-gcc --version
	arm-none-eabi-gcc (GNU Arm Embedded Toolchain 10.3-2021.10) 10.3.1 20210824 (release)
	Copyright (C) 2020 Free Software Foundation, Inc.
	This is free software; see the source for copying conditions.  There is NO
	warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.





