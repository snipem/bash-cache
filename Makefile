
test:
	bats tests/*

test_deps:
	brew install bats-core
	brew install kaos/shell/bats-assert
	brew install kaos/shell/bats-support
