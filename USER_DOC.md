# What is this for?

This project makes possible running a simple web stack composed of:
- a database (mariadb)
- a http server (nginx)
- a dinamically server side generated html application (wordpress).

With this simple stack you will be able to create and mantain
php web applications specially wordpress based applications, with necessary
persistence of data.

# How to execute the project

Being concise, the way to run this project is by running

```
make
```

on the root folder of this project.

[More specific instruction can be
found on README.md Instructions section](./README.md#Intructions)

[Another source of instruction can
be found on DEV_DOC.md](./DEV_DOC.md)

This command will make required setup if necessary and execute the services
required for the stack though the use of docker compose. Docker compose will
check the health status of the services and try to maintain services up and
running even in face of adversities that for some reason crash one of
the required services.

# How to customize the project

There is a configuration file at [´./srcs/.env´](./srcs/.env) that host some
customizable variables used by our services.
This customization should happen before setting up the project, because
some of these values are persisted on database and on wordpress generated
configuration '.php' files.

If you have a trusted certified ssl cetificate you should declare the folder
where they are residing and their filename on the appropriate ssl variables.
if you don't have one the setup will generate a self-signed one based on
`INCEPTION_SERVER_NAME` variable for local use. This self-signed depends on
having dns resolution configured by editing your systems `/etc/hosts`
configuration file.
If `INCEPTION_SERVER_NAME=maurodri.42.fr` then you should have this line on
`/etc/hosts`

```
127.0.0.1 maurodri.42.fr
```

which will make the address maurodri.42.fr available locally.

Folders used for data persistence are configurable on related host folder
variables

There are three secrets values required as part of the project setup
their location is fixed on `./secrets`, more specifically
- `./secrets/mariadb_pass`, which is database password of database user
- `./secrets/mariadb_root_pass`, which is database password of root user
- `./secrets/wordpress_admin_pass`, which is the wordpress admin password

if any of these files do not exist or are blank you will prompted to provide
these values on setup

In cases you have already setup the enviroment, but desire
to change configuration you can reset the enviroment and make a new setup with
the command

```
make re
```

this command will try to erase your host ssl and persistence folders
if they point to existing folders. Sudo permission is required
for this to happen.

If you happen to have valuable content on those folders _(please don't)_ make sure to back it up before running `make re`

# How to manage wordpress

After setup you should have a working wordpress instalation and a admin user
with username declared on `./srcs/.env` `WORDPRESS_ADMIN` with password equal
to the content of `./secrets/wordpress_admin_pass`

You can login at [https://$INCEPTION_SERVER_NAME/wp-admin],
where `$INCEPTION_SERVER_NAME` is the value of
`./srcs/.env` `INCEPTION_SERVER_NAME`

# Disclaimer

This project goal is for educational purposes and running
this for an actual production enviroment is not advised.
Prefer to use the oficial docker containers provided
by [mariadb](https://hub.docker.com/_/mariadb), [nginx](https://hub.docker.com/_/nginx) and [wordpress](https://hub.docker.com/_/wordpress).
This project provides no waranties and all negative effects of using this is on
your own responsability.
Copying and sharing is freely permited without any kind of requirements, not even
citation is needed.
Use this at your own will and responsability for any use you see fit for.
But please don't use this for production, this is not this project real goal.
