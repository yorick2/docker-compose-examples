# how to run
## update /etc/hosts file
Update the /ect/hosts file if you are running locally with your urls and 127.0.0.1 e.g.

127.0.0.1       l.test
127.0.0.1       l.testing
127.0.0.1       l.sample
127.0.0.1       l.example

## create docker network
Docker network create nginx-proxy
## start the test sites
Start the docker sites with port 80 exposed and attach to external network named nginx-proxy. Set the environment of VIRTUAL_HOST to the url


To run our docker-compose examples in our subfolders:
docker-compose -f l.test/docker-compose.yml up &&  docker-compose -f l.testing/docker-compose.yml up -d && docker-compose -f l.example/docker-compose.yml up -d && docker-compose -f l.sample/docker-compose.yml up -d
## start the nginx proxy
docker-compose up -d
## test the sites
Test the sites using curl or a web browser

