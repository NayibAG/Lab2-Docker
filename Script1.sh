#!/bin/bash 

# Create a container image using a web server base that contains this website and can be used to publish it just matching the ports

wget "https://www.free-css.com/assets/files/free-css-templates/download/page294/shapel.zip"
unzip shapel.zip

cd shapel-html
touch Dockerfile
echo "FROM httpd" > Dockerfile
echo "COPY . /usr/local/apache2/htdocs/" >> Dockerfile

docker build -f Dockerfile -t lab2 .
docker images

# Using the Docker CLI, create a container using this image and mapping the port 8080 from the host.
# Using the Docker CLI, create a MYSQL container linked with the website container. 
docker run -d --name db -e MYSQL_ROOT_PASSWORD=root mysql 
docker run -d --name lab2 -p 8080:80 --link db:db lab2 
docker ps
docker inspect lab2

docker stop lab2 db
docker rm lab2 db
docker rmi lab2 mysql