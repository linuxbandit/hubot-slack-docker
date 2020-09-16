default: start

start: build
	./start.sh

build:
	./start.sh build

monitor: start
	./start.sh watch