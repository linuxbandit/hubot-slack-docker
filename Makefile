default: start

.PHONY: build start monitor

start: build
	./start-dev.sh

build:
	./start-dev.sh build

monitor: start
	./start-dev.sh watch