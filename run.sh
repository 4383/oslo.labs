#!/usr/bin/env bash
set -e

if [ -z $1 ]; then
    echo "Please provide a lab to run!"
    echo -e "Example:\n\t$ ./run.sh labs/memcache_pool_backend"
    exit 1
fi

LAB=labs/$1
if [ ! -f "${LAB}/docker-compose-lab.yml" ]; then
    echo "Wrong path ${LAB}... dir exist but lab not found inside"
    exit 1
fi

docker-compose -f ${LAB}/docker-compose-lab.yml down
docker-compose -f ${LAB}/docker-compose-lab.yml build
docker-compose -f ${LAB}/docker-compose-lab.yml up -d
echo "=============================================================="
echo "Now connect to your lab by using:"
echo -e "\tdocker exec -it oslo-lab /bin/zsh"
echo "Stop your lab by using:"
echo -e "\tdocker-compose -f ${LAB}/docker-compose-lab.yml down"
echo "=============================================================="
