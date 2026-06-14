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
    if command -v tree &> /dev/null; then
        tree
    else
        find . -not -path "*/\.*" -not -path "*/node_modules/*" | sort
    fi
    ;;

clear_data)
    rm -f data/*.csv data/*.html 2>/dev/null
    echo "data cleared"
    ;;

inside_generator)
    docker run --rm -v $(pwd)/data:/data generator ls -la /data
    ;;

inside_reporter)
    docker run --rm -v $(pwd)/data:/data reporter ls -la /data
    ;;

build_server)
    docker build -t server -f Dockerfile.server .
    ;;

report_server)
    docker run -d --name server-container -p 8080:80 -v $(pwd)/data:/data server
    echo "Server started at http://localhost:8080/report.html"
    ;;

stop_server)
    docker stop server-container && docker rm server-container
    echo "Server stopped"
    ;;

*)
    echo "Unknown command"
    ;;

esac