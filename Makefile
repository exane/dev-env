build: .server.pid create-dockerfile
	docker build -t dev --rm .
	$(MAKE) -s shutdown

rebuild: .server.pid
	docker build --no-cache -t dev --rm .
	$(MAKE) -s shutdown

.server.pid:
	port=$$(ruby -e 'require "yaml"; puts YAML.load_file("./config.yml")["http"]["port"]'); \
	address=$$(ruby -e 'require "yaml"; puts YAML.load_file("./config.yml")["http"]["address"]'); \
	{ ruby -run -ehttpd ~ -p"$$port" -b"$$address" & echo $$! > $@; }

shutdown: .server.pid
	kill `cat $<` && rm $<

create-dockerfile:
	ruby -e 'require "erb"; puts ERB.new(File.read("./dockerfile.erb"), nil, "-").result' > dockerfile
