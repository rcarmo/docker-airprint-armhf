build: Dockerfile
	docker build -t rcarmo/airprint:armhf .

network:
	-docker network create -d macvlan \
	--subnet=192.168.1.0/24 \
        --gateway=192.168.1.254 \
	--ip-range=192.168.1.128/25 \
	-o parent=eth0 \
	lan

test: network
	docker run --net=lan -h cups rcarmo/airprint:armhf

shell:
	docker run --net=lan -h cups -it rcarmo/airprint:armhf /bin/bash

push:
	docker push rcarmo/airprint
