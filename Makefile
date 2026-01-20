


docs-show: 
	make docs-build
	npx serve docs

docs-build:
	lake build Math:docs
	cp -r ./.lake/build/doc ./docs

build: 
	lake build

run: 
	lake build 
	lake exec math

update: 
	MATHLIB_NO_CACHE_ON_UPDATE=1 lake update doc-gen4
	lake update