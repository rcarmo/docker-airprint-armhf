# docker-airprint-armhf

This is a Docker container for setting up an AirPrint server on `armhf` machines like the Raspberry Pi or the ODROID-U2. It assumes you're bridging it to your LAN using the `macvlan` network driver, and is designed to be installed, configured, and then frozen via `docker commit`.

## Usage

See the `Makefile` for an example of how to set up the `lan` network. After that's running, do:

	docker run -ti --net=lan -h cups rcarmo/airprint:armhf
	
	# now go to https://cups.local:631/admin, login as cups/cups and add your printer
	
	# then commit the configured container
	docker commit <your container PID> airprint:configured
	
	# set up configured container as daemon
	docker run -d --restart unless-stopped --net=lan -h cups airprint:configured


## Notes

The `urftopdf` folder contains a snapshot of [this repo][u] with greyscale 8 bit unirast support, which may come in useful depending on the version of CUPS. It is not added to the container by default (yet).

[u]: https://github.com/superna9999/urftopdf
