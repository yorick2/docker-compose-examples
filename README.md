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

# ssh into container
sudo docker exec -it <<container name>> bash

# startup the docker composition
docker-compose up
To rebuild this image you must use `docker-compose build`

# access mysql 
mysql -h<<image ip>> --port=9906 -udevuser -p
or 
mysql -h<<image ip>> --port=9906 -uroot -p

# run website in browser
http://<docker-host-ip-address>:8080
 
# notes
https://docs.docker.com/compose/production/

based on:
https://medium.com/@meeramarygeorge/create-php-mysql-apache-development-environment-using-docker-in-windows-9beeba6985
https://stackoverflow.com/questions/29480099/docker-compose-vs-dockerfile-which-is-better

