makefile_dir		:= $(abspath $(shell pwd))

port				:= 8000

list:
	@grep '^[^#[:space:]].*:' Makefile | grep -v ':=' | grep -v '^\.' | sed 's/:.*//g' | sed 's/://g' | sort

serve:
	mkdocs serve --dev-addr 0.0.0.0:$(port)

build:
	mkdocs build

build-clean:
	mkdocs build --clean

publish:
	mkdocs gh-deploy

purge:
	rm -rf site
