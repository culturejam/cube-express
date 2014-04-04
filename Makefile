REPORTER = spec

test:
	@NODE_ENV=test ./node_modules/mocha/bin/mocha \
		--reporter $(REPORTER) \
        --compilers coffee:coffee-script/register \
        --require should \
	--ui bdd \
	--recursive
	./test/

.PHONY: build clean watch test

