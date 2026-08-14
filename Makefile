.PHONY: verbose dev setup custom setup-custom test

all: setup

test:
	./run-tests

verb: verbose

verbose:
	./setup --verbose

dev:
	./setup --dev

setup:
	./setup

custom: setup-custom

setup-custom:
	./setup-custom
