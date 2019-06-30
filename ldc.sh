#!/bin/bash

if  ! hash docker-compose 2>/dev/null
then
    echo "docker compose is not installed, you must install docker-compose!"
    exit
fi

if [[ "$1" == "" ]]
then
    echo "accepted language:"
    echo "  php"
    echo "  python"
    echo "  node"
    exit
fi

if [[ "$1" == "php" ]] || [[ "$1" == "composer" ]]
then
    image="php"
elif [[ "$1" == "node" ]] || [[ "$1" == "npm" ]]
then
    image="node"
elif [[ "$1" == "python" ]] || [[ "$1" == "pip" ]]
then
    image="python"
else
    echo "language not found!"
    exit
fi

container_name="dc_${image/\//_}"
yml_name="docker-compose-$container_name.yml"
command=""
for var in "$@"
do
    command="$command $var"
done

if [[ command != "" ]]; then
    docker ps -aq --filter="name=$container_name" | xargs docker rm > /dev/null
    echo "version: '3'" > $yml_name
    echo "" >> $yml_name
    echo "services:" >> $yml_name
    echo "  nodejs:" >> $yml_name
    echo "    container_name: $container_name" >> $yml_name
    echo "    image: $image" >> $yml_name
    echo "    volumes:" >> $yml_name
    echo "      - .:/home/app" >> $yml_name
    echo "    command: sh -c \"cd /home/app && $command\"" >> $yml_name
    docker-compose -f $yml_name up
    rm $yml_name
fi