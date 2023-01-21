.PHONY := all

all:
	git clone https://github.com/buildroot/buildroot
	cd buildroot ; git apply ../mediaplayer.patch ; $(MAKE) raspberrypi4_64_mediaplayer_defconfig
	$(MAKE) -C buildroot 
	cp -r mdev buildroot/output/target/etc
	chmod a+x buildroot/output/target/etc/mdev/mount.sh
	echo 'sd[a-z][0-9]*	root:root 660 @/etc/mdev/mount.sh add $$MDEV' >> buildroot/output/target/etc/mdev.conf
	echo "dtparam=audio=on" >> buildroot/output/images/rpi-firmware/config.txt
	$(MAKE) -C buildroot