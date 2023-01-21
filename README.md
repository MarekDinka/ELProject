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
