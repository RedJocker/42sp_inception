#!/bin/bash

SECRETS_FOLDER=secrets

read_secret() {
    local prompt="$1"
    password=""
    while [ -z "$password" ]; do
	echo "$prompt"
	read -sp "password: " password
	echo ''
	if [ -z "$password" ]; then
	    echo "Empty password is not valid"
	fi
    done
}

if ! [ -f Makefile ]; then
    echo 'run make on same directory as Makefile'\
	 'to be able to setup secrets'
    exit 1
fi

if ! [ -d srcs ]; then
    echo 'run make on same directory as srcs'\
	 'to be able to setup secrets'
    exit 1
fi

if ! [ -d "$SECRETS_FOLDER" ]; then
    mkdir ./"$SECRETS_FOLDER"
fi

if ! [ -s "$SECRETS_FOLDER"/mariadb_pass ]; then
    password=""
    read_secret "Input password for mariadb user"
    echo -n "$password" > "$SECRETS_FOLDER"/mariadb_pass
    unset password
fi

if ! [ -s "$SECRETS_FOLDER"/mariadb_root_pass ]; then
    password=""
    read_secret "Input password for mariadb root"
    echo -n "$password" > "$SECRETS_FOLDER"/mariadb_root_pass
    unset password
fi


if ! [ -s "$SECRETS_FOLDER"/wordpress_admin_pass ]; then
    password=""
    read_secret "Input password for wordpress admin"
    echo -n "$password" > "$SECRETS_FOLDER"/wordpress_admin_pass
    unset password
fi

exit 0
