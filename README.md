# My embedded linux project
## Project target
My target in this project was to make a rpi OS that will automaticaly start playing all .mp3 files on USB, when said USB is connected. I seem to have achieved this using mdev to detect USB being connected and mpg123 to play all .mp3 files found on it.
## Testing the image
**this project has been compiled on raspberry pi 4 64bit version and may not work on others.**
In order to test the image you must connect an sd card and launch the following commands <br>
`make`<br>
`sudo dd if=buildroot/output/images/sdcard.img of=/dev/sdb` <br>
*note: no partitions are required .img will do that it self, the sd card should be umounted first*
## What have i done to get here
- `make raspberrypi4_64_defconfig`
- in `make menuconfig` <br>
```
Toolchain
    Toolchain type (External toolchain)
System Configuration
    /dev management (Dynamic using devtmpfs+mdev)
Filesystem images
	(1G) exact size
Target packages
	Audio and video applications  --->
		[*] alsa-utils  --->
			[*]   alsaconf
 			[*]   aconnect
 			[*]   alsactl
 			[*]   alsaloop
 			[*]   alsamixer
 			[*]   alsaucm
 			[*]   alsatplg
 			[*]   amidi
 			[*]   amixer
 			[*]   aplay/arecord
 			[*]   aplaymidi
 			[*]   arecordmidi
 			[*]   aseqdump
 			[*]   aseqnet
 			[*]   bat
 			[*]   iecset
 			[*]   speaker-test
		[*] mpg123
		[*] vlc
	Hardware handling  --->
		[*] mdevd
```
- in `make linux-menuconfig` <br>
```
Device Drivers  --->
	[*] PCI support
        check all
	<*> Sound card support --->
        <M> Advanced Linux Sound Architecture ---> 
            allow every single one you can find to M or better (i have had a lot of trouble with sound not working)
	[*] USB support  --->
		{*}   Support for Host-side USBUSB
        <*>   EHCI HCD (USB 2.0) support
		<*>   OHCI HCD (USB 1.1) support
		<*>   USB Mass Storage support
```
- after doing `make` i have added `sd[a-z][0-9]* root:root 660 @/etc/mdev/mount.sh add $MDEV` to `target/output/etc/mdev.conf`, so that mdev launches mount.sh every time a usb is connected
- added `mount.sh` to `etc/mdev/mount.sh` (i got it from internet and then added the music playing function) and given it execute permissions
- `make` again to get the latest changes to .img and flashed .img -> `sudo dd if=output/images/sdcard.img of=/dev/sdb`