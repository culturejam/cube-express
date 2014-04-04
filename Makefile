REPORTER = spec

test:
	@NODE_ENV=test ./node_modules/mocha/bin/mocha \
		--reporter $(REPORTER) \
        --compilers coffee:coffee-script/register \
        --require should \
		--ui bdd \
		test/**/*.coffee

.PHONY: build clean watch test

