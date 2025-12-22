_This project has been created as part of the 42 curriculum by maurodri_

# Description

On Inception project we focus on devops side of computer practics. We set up
a Virtual Machine on the computer environment provided by 42 institute and, 
using our root privileges on this virtual machine, 
our goal is to declare a cluster of services for a simple web stack 
accessible with https on a domain that is based on my login `maurodri.42.fr`. 
This simple web stack - composed of nginx, wordpress(php-fpm) and mariadb -
is declared and exectuted using docker, 'docker compose' and their related files.

All declared containers must be based either on alpine or debian 
on a fixed version (I have choosen alpine:3.23.0 for all), which means 
we are responsible for all the intra container setup necessary for each service
including scripted instalation steps that are persisted through bind volumes.

We also are required to make the cluster configurable through a .env file and
to manage sensitive data using secrets.
This means a theoretical user could change the .env and setup up the enviroment
to run his own version of the system with his custom values

A final requirement is to use make to simplify project setup and execution
for users. 
This make file will create the necessary folders for bind mounts,
create ssl cetificates if they do not exist on path specified on .env,
create folders for secret files and the secret files itself by prompting the user

# Instructions
## Dependencies
To be able to run this project you will need
- bash command available on path
- openssl command available on path
- to be able to download the source code of this repository, likely using git
- to be able to run this project Makefile using make
- docker command available on path
- either 'docker compose' or docker-compose command available on path

This project was developed on a virtual machine with Debian 13, but also has
been tested on Alpine:3.21.3.
Other systems may work fine but they were not tested.

## Setup
It is possible to setup the project with the same procedure used to execute it
just by changing the current folder to this project root directory 
(where Makefile exists) and executing
```
make
```
The lack of setup should be detected and setup steps should be executed.
To customize the enviroment, before doing this initial run you can change
the file located at `./srcs/.env`, which host configurable variables for our 
project, so that the setup include these variables.
It is not advised to change .env variables after setup as some of these values
are persisted on bind volumes data and cause unexpected behaviour due to 
conflicting values between volumes and enviroment variables.
To reset the setup and create a new one you can execute
``` 
make re
```
but current exiting data may be lost so back it up if it is valuable to you.

## Execution
To execute the project you do the same as the setup and just call

```
make
```

this will detect that setup already exists and exectute commands to create
the service cluster, managed by docker compose with healthchecks and restart
policies.

to skip setup detection you can use

```
make up
```

to stop containers you can either type ctrl-c on same shell make is executing,
or execute 

```
make stop
```

to also clear containers you can execute

```
make down
```

# Resources
## Docker
- [subject](https://cdn.intra.42.fr/pdf/pdf/119221/en.subject.pdf)
- [docker tutorials](https://learndocker.online/courses/)
- [install docker](https://docs.docker.com/engine/install/debian/#install-from-a-package)
- [docker depends_on and healthcheck video reference](https://www.youtube.com/watch?v=pCY6khpKqM4)
## Mariadb
- [mariadb-safe](https://mariadb.com/kb/en/mariadbd-safe/)
- [mariadb wiki](https://wiki.alpinelinux.org/wiki/MariaDB)
- [mariadb-install](https://mariadb.com/kb/en/installing-system-tables-mariadb-install-db/)
## Nginx
- [youtube - NGINX tutorial for Beginners](https://www.youtube.com/watch?v=9t9Mp0BGnyI)
- [youtube How to Configure PHP for Nginx with PHP-FPM on Ubuntu](https://www.youtube.com/watch?v=1P54UoBjbDs)
- [youtube Optimizing nginx and PHP-FPM – from Beginner to Expert to Crazy | Arne Blankerts](https://www.youtube.com/watch?v=VtKTOZFfoug)
## SSL
- [ssl certificates](https://letsencrypt.org/docs/certificates-for-localhost/) 

## Usage of AI while developing project

I personally believe that knowledge aquisition is a journey that requires
active mental engagement, and since the real purpose of this project 
is my own education I tried to minimize any kind of activity that would
provide me ready made solutions. Methaforically speaking, teleporting my way 
into the end of project would not provide me the oportunity 
to collect the fruits of knowledge that are only available along 
the enlighment journey path.

Thus the usage of AI was limited and scoped as to not interfere on knowledge
aquisition. My development environment was on an emacs without any integreted ai
assistence (although it is perfectly possible to have that if desired).

There were two points in which some ai assistence was used though. 
One point was as part of research and second point was as debug tool.

As part of research I consider AI on one hand to be practical, but 
on other hand to be a very low trustworthy resource.
First hand resources were prefered whenever possible, limited only by my 
knowledge of their existence or by my comprehension over that resource.
Second hand trustworthy resources where prefered as aid whenever my limitations
over aquiring and comprehending the First hand resources were at play.
Ai played a role only on the absence of the other kind of resources or as a
way to discover their existence, directly or indirectly. And still on this point
search applications were still prefered, with my prefered one being duckduckgo,
but also 'youtube search' was often used.

Using AI as debug tool was probably the biggest point of use of AI in this project.
This use case often involved copy and pasting error messages, or explaining
my situation and objectives to AI. As AI chats happens in sessions one same
session could have several alternations between explanations, goal settings and
error message copy and pasting.
Still here the traditional search for error messages method was also used 
leading often to some stackoverflow (or similar) mention on results.



# Background information
## Virtual Machines vs Docker
[CS 667 - Virtualization](https://www.youtube.com/watch?v=EP3hGTGJk2g&list=PLacuG5pysFbC6wIJAneKKpgcKA8Ub34x6&index=8)

[CS 667 - OS Virtualization, Containers, Process migration](https://www.youtube.com/watch?v=L9AEeci7XkY&list=PLacuG5pysFbC6wIJAneKKpgcKA8Ub34x6&index=10)

[CS 667 - Migration and Container Orchestration](https://www.youtube.com/watch?v=w3U_K9nElk4&list=PLacuG5pysFbC6wIJAneKKpgcKA8Ub34x6&index=10)

There are many layers of virtualization possible. 

The highest level is *Full Emulation*
in which the whole hardware is emulated. This is used for example on QEMU, which
is often used to emulate mobile hardware on desktops. This level allows running
any kind of architecture as guest os at a performance penalty cost since every
single instructions has to be translated.

Another kind of virtualization is *Native Virtualization*. 
In this kind hardware is partly shared and only 'enough' is emulated.
This level requires guest OS to be same architecture as the machine it runs over.
So on a x86_64 machine only OSs that are also x86_64 will be able to run as guest OS.
This is the level in which VirtualBox acts, which was used as underlying setup 
for this project.

In *Para-Virtualization* there is no hardware emulation and the guest OS has
special modifications to talk to hypervisor. 
The guest OS is in some level aware of emulation.

On *OS-level virtualization* the 'guest OS' is "the same" as the 'host OS',
but appears to be isolated. Being the same here means sharing same kernel for example.
This is the level in which Docker acts, and also other solutions like Linux Containers.
In this project for example we have alpine containers running on top of a debian host os.
Although these are very different distributions of linux, 
they both share same linux kernel.
This allows less resource duplication as different containers may share same resources
although guest OSs believe to be isolated (at least at some level)

One final kind of virtualization is *Application-level Virtualization*, in this
kind the application itself is responsible for translation layers to run 
some 'machine independent application'. This is the level of a JVM and also
of solutions like Wine and Rosseta.

## Secrets vs Environment Variables
[Docker Compose: Mastering Environment Variables for Configuration](https://www.youtube.com/watch?v=Xpk82bWEBbw)

[docker secrets - youtube shorts](https://www.youtube.com/shorts/xE1n983-Cv8)

*Enviroment Variables* allows us to have some level of runtime configuration for
our applications. This allows some level of customization for our applications
and thus we can design more generalized solutions that can be reused for
different use cases or end users.
*Secrets* are a special kind of Enviroment Variable that have a sensitive nature.
Secrets should not be exposed to the general public and keeping the secret a secret 
is a security concern. Secrets are often part of authentication 
for authorized only resource consumption. 
Often this resource consumption is a billed service like an API_KEY,
but it might just be a protected resource that only some roles may consume like
a database password.

On our project *Enviroment Variables* are declared on `./srcs/.env` and passed
to `./Makefile` by direct inclusion, to `./srcs/docker-compose.yml` by automatic
inclusion, to each service enviroment through each service declaration 
on `./srcs/docker-compose.yml` and finally some templates config files have
variables replaced using envsubst on a entrypoint script setup previous to
the target service to be executed at the end of the entrypoint script.
As there are no sensitive content by this project included on `./srcs/.env`, it
is included as part of the versioning system and thus acting as documentation
over the possible configurations of the solution offered by this project.

On our project *Secrets* follow a different mechanic and remain separate from
`./srcs/.env` allowing this `./srcs/.env` to be shareable as it does not contain
any sensitive information. *Secrets* are declared on special files that are not
supposed to be included on codebase versioning systems nor shared, instead these
are supposed to be only part of 'production enviroment'. 
Docker compose provides special syntax for secrets inclusion and on runtime
containers these will be mapped into files living in `/run/secrets` folder

As part of setup process we create those secret files only if the 
'production enviroment' does not already have them.

## Docker Network vs Host Network

Docker is a solution for providing isolated enviroments for our services to run
over. It thus make sense that these services are not reachable. 
On the other hand we want to be able to have some way to talk to the service
otherwise running can becomes kind of pointless. Also is often the case we
want to run not just a single service, but a cluster of interdependent services and
thus have some communication set between them.
Docker Networks provide this communication layer that allows services to
talk between them and to the host OS. This communication layer uses the same
abstraction used for general networking, with ip addresses, dns resolution, ports.
Docker provides this communication layer and a declarative way to expose only
the necessary parts keeping isolation as the primary goal.

Host network is the one we are used to, the only special attention this project
requires is at configuring the `/etc/hosts` file on host OS for internal 
dns resolution as our required to be used domain is not a valid public registered domain 


## Docker Volumes vs Bind Mounts

Persistence is often something needed for services. 
These services are considered stateful services.

There are two general solutions provides for achieving persistence.

One solution is volumes. Volumes, named or annonymous, are docker managed
persistent memory. These will live somewhere on your host os, but will be
created and managed by docker with some level of isolation and should not
be managed directly, only through docker available commands and apis.

Bind volumes are mapping of common folders from host OS into containerized
folders. These are effectively the same persistent memory region on your
host machine. One can see and change the content of these folders just like any
folder, although there may be issues of ownership and permissions either by
container or host OS that limit manipulation of the content of these folders.
