test:
	@NODE_ENV=test ./node_modules/mocha/bin/mocha \
		--reporter spec \
        --compilers coffee:coffee-script/register \
        --require should \
	--ui bdd \
	--recursive

.PHONY: build clean watch test

