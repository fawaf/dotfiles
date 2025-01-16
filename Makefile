all: setup

verb: verbose

.PHONY: verbose
verbose:
	./setup --verbose

.PHONY: dev
dev:
	./setup --dev

.PHONY: setup
setup:
	./setup

.PHONY: custom
custom: setup-custom

.PHONY: setup-custom
setup-custom:
	./setup-custom
