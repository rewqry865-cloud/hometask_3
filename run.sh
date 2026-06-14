#!/bin/bash

case "$1" in

build_generator)
    docker build -t generator -f Dockerfile.generator .
    ;;

run_generator)
    docker run --rm -v $(pwd)/data:/data generator
    ;;

create_local_data)
    python generate.py local_data
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
    docker run --rm -v $(pwd)/data:/data generator ls -la /data
    ;;

inside_reporter)
    docker run --rm -v $(pwd)/data:/data reporter ls -la /data
    ;;

report_server)
    docker run -d --name server-container -p 8080:80 -v $(pwd)/data:/data server
    ;;

stop_server)
    docker stop server-container && docker rm server-container
    echo "Server stopped"
    ;;

*)
    echo "Unknown command"
    ;;

esac