makefile_dir		:= $(abspath $(shell pwd))

list:
	@grep '^[^#[:space:]].*:' Makefile | grep -v ':=' | grep -v '^\.' | sed 's/:.*//g' | sed 's/://g' | sort

serve:
	mkdocs serve

build:
	mkdocs build

build-clean:
	mkdocs build --clean

purge:
	rm -rf site
