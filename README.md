# STR32-Programming-within-WSL-Ubuntu-Test
Testing out arm-gcc build toolchain, OpenOCD programming and gdb debugging from scratch using WSL2 (Ubuntu 24.04) in x86-64 Windows 11 host machine environment


Important: WSL2 does not natively support the recognizing of USB devices connected to the host Windows 11 machine. In order to get this working, there is some WSL configuration you need to do:
Useful guides here: 
  - https://learn.microsoft.com/en-us/windows/wsl/connect-usb#install-the-usbip-tools-and-hardware-database-in-linux
  - https://hackmd.io/@aeefs2Y8TMms-cjTDX4cfw/r1fqAa_Da#My-setup

	• Installs usbipd in windows host
	• Attaches desired usb devices to wsl2 so that ubuntu subsystem can access it
	• Sets up permissions in ubuntu for usb debugging as ,$USER> user, not just root
		○ "Ensure that the device is accesible by plugdev group and also the read, write permissions"
    ○ Use 'ls -l /dev/bus/usb/<Bus>/<Device>' where bus and device can be obtained by using lsusb command in ubuntu


Now, the device should be accessible to wsl2 applications

NOTE: YOU WILL HAVE TO RERUN "usbipd attach --wsl --busid <BUSID>" IN WINDOWS 11 SHELL EVERYTIME YOU PHYSICALLY DISCONNECT THE STM32


