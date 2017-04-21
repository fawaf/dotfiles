all: setup

verb: verbose

verbose:
	./setup.rb --verbose

dev:
	./setup.rb --dev

setup:
	./setup.rb

custom: setup-custom

setup-custom:
	./setup-custom.rb
