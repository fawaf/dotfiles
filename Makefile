.PHONY: verbose dev setup custom setup-custom

all: setup

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
