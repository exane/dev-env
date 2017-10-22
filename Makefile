build: server.PID
	docker build -t dev --rm .
	$(MAKE) -s shutdown

server.PID:
	{ ruby -run -ehttpd ~ -p8080 -b192.168.99.1 & echo $$! > $@; }

shutdown: server.PID
	kill `cat $<` && rm $<
