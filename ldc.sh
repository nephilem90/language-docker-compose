#!/bin/bash

if  ! hash docker 2>/dev/null
then
    echo "docker is not installed, you must install docker!"
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

if [[ command != "" ]]; then
    docker run --rm -v "$PWD":/home/app "$image" "$@"
fi