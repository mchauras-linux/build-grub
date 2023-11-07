#! /bin/bash

docker build --build-arg branch=retry --tag grub_suse:latest . --network host
docker run -it --network host grub_suse
