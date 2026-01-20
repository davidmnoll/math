


docs:
	lake build Math:docs
	mv ./.build/docs ./docs

build: 
	lake build

run: 
	lake build 
	lake exec math

update: 
	MATHLIB_NO_CACHE_ON_UPDATE=1 lake update doc-gen4
	lake update