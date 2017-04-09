IMAGE_NAME=rcarmo/airprint:armhf
build: Dockerfile
	docker build -t ${IMAGE_NAME} .

network:
	-docker network create -d macvlan \
	--subnet=192.168.1.0/24 \
        --gateway=192.168.1.254 \
	--ip-range=192.168.1.128/25 \
	-o parent=eth0 \
	lan

test: network
	docker run --net=lan -h cups ${IMAGE_NAME}

shell:
	docker run --net=lan -h cups -it ${IMAGE_NAME} /bin/bash

push:
	docker push ${IMAGE_NAME}

clean:
	-docker rm -v $$(docker ps -a -q -f status=exited)
	-docker rmi $$(docker images -q -f dangling=true)
	-docker rmi $(IMAGE_NAME)
