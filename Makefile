generate_certificates:
	ls ~/data/ssl > /dev/null || mkdir -p ~/data/ssl
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout ~/data/ssl/maurodri.key \
		-out ~/data/ssl/maurodri.crt \
		-subj "/CN=maurodri.42.fr" \
		-addext "subjectAltName = DNS:maurodri.42.fr, DNS:localhost"
