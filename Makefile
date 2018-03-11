build: build.pid create-dockerfile
	docker build -t dev --rm .
	$(MAKE) -s shutdown

rebuild: build.pid
	docker build --no-cache -t dev --rm .
	$(MAKE) -s shutdown

build.pid:
	./bin/build& echo $$! > $@

shutdown: build.pid
	kill `cat $<` && rm $<

create-dockerfile:
	ruby -e 'require "erb"; puts ERB.new(File.read("./dockerfile.erb"), nil, "-").result' > dockerfile
