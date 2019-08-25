provision:
	(cd ops && make apply)

deploy:
	(cd app && ./bin/deploy)

ingress:
	(cd op && make ingress)

hostname:
	(./bin/update_hosts)
