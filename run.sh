#! /bin/bash
# Check if at least one argument is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <branch name>"
    exit -1
fi

docker build --build-arg branch=$1 --tag suse:latest . --network host
docker run -it --network host suse
