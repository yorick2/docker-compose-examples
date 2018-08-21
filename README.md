A docker image test

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
## ssh into a container
sudo docker exec -it <<container name>> bash
### Delete all containers
Warning: This will destroy all your images and containers. It will not be possible to restore them!
docker rm $(docker ps -a -q)
### Delete all images
Warning: This will destroy all your images and containers. It will not be possible to restore them!
docker rmi $(docker images -q)

# startup the docker composition
docker-compose up
To rebuild this image you must use `docker-compose build`

# access mysql 
## from the host machine (external to the docker containers)
mysql -h<<image ip>> --port=9906 -udevuser -p
or 
mysql -h<<image ip>> --port=9906 -uroot -p

## from inside a container
You cannot run mysql from inside another container but can connect to mysql from inside another container. The ame of the container is
used for the url. The other details are
host: db;
user: devpass
password: devtest
port: 3306 

test the connection
php /code/test_mysql_connection.php

# linked folders
 my-web-php7.0:/code .


# containers created
php & apache (my-web-php7.0):
php 7.0
apache 5.7

mysql:
mysql 5.7

// Create connection
$conn = new mysqli($servername, $username, $password);

# run website in browser
http://<docker-host-ip-address>:8080
 
# notes
https://docs.docker.com/compose/production/

based on:
https://medium.com/@meeramarygeorge/create-php-mysql-apache-development-environment-using-docker-in-windows-9beeba6985
https://stackoverflow.com/questions/29480099/docker-compose-vs-dockerfile-which-is-better

