#!/bin/bash

case "$1" in

build_generator)
    docker build -t generator -f Dockerfile.generator .
    ;;

run_generator)
    docker run --rm -v $(pwd)/data:/data generator
    ;;

create_local_data)
    python generate.py
    ;;

build_reporter)
    docker build -t reporter -f Dockerfile.reporter .
    ;;

run_reporter)
    docker run --rm -v $(pwd)/data:/data reporter
    ;;

structure)
    tree
    ;;

clear_data)
    rm -f data/*.csv data/*.html
    ;;

inside_generator)
    docker run --rm -it -v $(pwd)/data:/data generator sh
    ;;

inside_reporter)
    docker run --rm -it -v $(pwd)/data:/data reporter sh
    ;;

report_server)
    docker run --rm -p 8080:80 -v $(pwd)/data:/data server
    ;;

*)
    echo "Unknown command"
    ;;

esac