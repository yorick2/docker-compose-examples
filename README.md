Some docker image test

# Tricks
## copy from one container to another
This is useful if something is compiled. The compiler can run then stop and the compiled file can be used in your main container.
## extend-a-local-base-image
One container is used as a base image and one container that builds its image from that.
- Splitting a dockerfile into multiple stages can be useful. In the example if we make changes to the main containers dockerfile, we just rebuild the main container i.e. only follow the steps in that dockerfile to the base image. This can save alot of time if the base image has alot of steps.
- This can also be useful for having both development and poduction containers, created from a base web server image.
## multiple-versions-in-the-same-file
This is similar to extend-a-local-base-image. But when its built using docker-compose it will always build all the stages in the Dockerfile, until it gets to the last stage required.
It multiple stages in one file but this may contain unwanted stages and is often wasteful in my opinion. But it can be useful if the container has two or more states without much difference, or that extend others. Like the exmaple here. In which case the order the stages are in the file should be considered. 

| Our container | dependancies        | built stages in our example |
| ------------- |---------------------| --------------------------- |
| base          |                     | base                        |
| prod          | base                | base,prod                   |
| stage         | base                | base,prod,stage             |
| dev           | prod,base           | base,prod,stage,dev         |

Here the order is based on limiting server build time and taking the penalty on dev setup time. This could be reduced by using a seperate Dockerfile for the dev stage and a seperate docker-compose.yml file for development environment to allow it to be used safly and reliably.

# Server examples 
## based-on-ubuntu
This is a simple php, apache, mysql container that uses a ubuntu container.
## host-multiple-docker-sites
This shows how to use an nginx-proxy docker container to allow multiple sites to run, each with site with a seperate web server docker container e.g. nginx or apache
## multiple-php-versions-using-official-php-container
This shows how to use docker compose to run multiple versions of php symltaniously while using the same mysql container. This can be useful for testing a site on multiple versions of php or running multiple sites that require different php versions on your local.
## using-official-php-container
This is a php, apache, mysql setup that uses an official php apache container

# working with a container
## create a container 
sudo docker build -t <<<image name>>> .
## run an image instance of the container
sudo docker run -p 8080:80 -d -v ~/Documents/Repositories/sites:/var/www/Website --name <<container name>> <<image name>>
### explanation
#### linked ports 
-p 8080:80
#### linked volumes
-v ~/Documents/Repositories/sites:/var/www/Website
## run a terminal in a container
sudo docker exec -it <<container name>> bash
Some containers have a different setup. These are some other options if that one dosen't work.
sudo docker exec -it <<container name>> /bin/bash
sudo docker exec -it <<container name>> sh
sudo docker exec -it <<container name>> /bin/sh
### terminal into a container image
This is useful to have a look around a container that dose a job and exits.
`docker run -it  compiler bash`
### terminal into a stopped container
- Commit the stopped container into an image
docker commit <<container id>> debug/<<my container>>
- create a new container from the "broken" image
docker run -it --rm --entrypoint sh debug/<<my container>>
- delete the container and the image
docker image rm debug/<<my container>>
### Stop all running containers
Warning: This will stop all your containers.
docker stop $(docker ps -a -q)
### Delete all containers
Warning: This will destroy all your images and containers. It will not be possible to restore them!
docker rm $(docker ps -a -q)
### Delete all images
Warning: This will destroy all your images and containers. It will not be possible to restore them!
docker rmi $(docker images -q)

# docker compose
## startup the docker composition
This will create a container and start it. This will only build a container if it dosen't exist.
docker-compose up
## rebuild a docker-compose images
To rebuild this image you must use `docker-compose build`. To stop docker using the cache add the `--no-cache` flag 'e.g. `docker-compose build --no-cache`
### build a single container
`docker-compose build <<container name>>`
# access mysql 
## from the host machine (external to the docker containers)
mysql -h<<image ip>> --port=9906 -udevuser -p
or 
mysql -h<<image ip>> --port=9906 -uroot -p

## from inside a container
You cannot run mysql from inside another container but can connect to mysql from inside another container. The name of the container is
used for the url. The other details are
host: db;
user: devpass
password: devtest
port: 3306 

test the connection
php /code/test_mysql_connection.php

# tests
## connection tests
Included are some test files to test that php, apache and mysql connections work. The list of tests are accessable from. The port can be found in the docker-compose.yml for the example. 
http://localhost:<<port>>/docker-tests/

e.g
http://localhost:8000/docker-tests/

# linked folders
 my-web-php7.0:/code .


# containers created
php & apache (my-web-php7.0):
php 7.0
apache 5.7

mysql:
mysql 5.7

# run website in browser
http://<docker-host-ip-address>:8080
 
# notes
https://docs.docker.com/compose/production/

based on:
https://medium.com/@meeramarygeorge/create-php-mysql-apache-development-environment-using-docker-in-windows-9beeba6985
https://stackoverflow.com/questions/29480099/docker-compose-vs-dockerfile-which-is-better

