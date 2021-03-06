#!/bin/bash

go get -d -t $1 2> /dev/null

if [ $? -gt 0 ]; then
    echo "Cannot get '$1'" >&2
    exit 1
fi

cd $1

go test -covermode=count -coverprofile=coverage.out > /dev/null

if [ $? -gt 0 ]; then
    echo "Cannot test '$1'" >&2
    exit 2
fi

if [ ! -f coverage.out ]; then
    echo "No test files for '$1'" >&2
    exit 3
fi

go tool cover -html=coverage.out -o=/dev/stdout

if [ $? -gt 0 ]; then
    echo "Cannot get coverage of '$1'" >&2
    exit 4
fi
