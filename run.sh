#! /bin/bash

docker build --build-arg branch=retry --tag suse:latest . --network host
docker run -it --network host suse
