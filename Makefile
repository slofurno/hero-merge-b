.PHONY: build run

build:
	docker build -t hero-merge-b .

run:
	docker run --rm --name heromerge -p 4001:4001 --net=host hero-merge-b
