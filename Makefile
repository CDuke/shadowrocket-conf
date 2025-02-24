.PHONY: lint
lint:
	shellcheck build.sh

.PHONY: build
build:
	./build.sh