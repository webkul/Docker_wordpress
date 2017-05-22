#WORDPRESS

Wordpress is a free and opensource content management system based on PHP and mysql. 

Wordpress works with older versions of PHP and mysql but we recommend you to use stable and newer/latest versions of PHP and mysql to get better performance. For that, I have used:

> OS: ubuntu-14.04

> Web Server: Apache-2.4.7

> Database Management System: Mysql-5.6.3

> PHP-7.0.14

> PHP-extensions: php7.0-curl php7.0-intl php7.0-gd php7.0-dom php7.0-mcrypt php7.0-iconv php7.0-xsl php7.0-mbstring php7.0-ctype php7.0-zip php7.0-pdo php7.0-xml php7.0-bz2 php7.0-calendar php7.0-exif php7.0-fileinfo php7.0-json php7.0-mysqli php7.0-mysql php7.0-posix php7.0-tokenizer php7.0-xmlwriter php7.0-xmlreader php7.0-phar php7.0-soap php7.0-mysql php7.0-fpm .

> Wordpress 4.7

# DOCKERIZING WORDPRESS STORE

Docker is an open-source project that automates the deployment of applications inside software containers. Wordpress can be dockerized and can be run inside light weight containers. 
Dockerizing begins with writing Dockerfile that holds the installation and configuration steps. Dockerfile for wordpress gets started with pulling an image of ubuntu 14.04 OS and updating the server. It is followed by installation of apache server, mysql-server, and php along with its extensions. Then download compressed wordpress-4.7 package and unzip it in the desirable directory. Docker runs single process at a time so we are going to need supervisor for handling multiple processes, here managing apache2 and mysql server. We are copying 000-default.conf file and wp-config.php file from host to docker container. Also a database named 'test' and a user 'admin' is being created using mysql.sh script being called upon by supervisor and password for database is set randomly by password.sh script that is stored in path /etc/flag inside container and also mentioned in wp-config.php in wordpress server directory (Don't forget to remove /etc/flag after launching the conatiner). 

So, lets make all this working:

> Clone or download this repository.

> To bulid docker image from dockerfile, run command "docker build -t image_name /path/to/dockerfile"

> To list the images, run command "docker images"

> To remove image, run command "docker rmi image_name"

> To launch container, run command "docker run -d -p 8080:80 -p 3306:3306 --name container_name image_name:latest"
  (No other services should be running on port 8080 and 3306)

> To list running containers, run command "docker ps"

> To remove /etc/flag file (recommended), run command "docker exec -ti container_name rm /etc/flag"

> To use container shell, run command "docker exec -ti container_name bash"

> To stop the container, run command "docker stop container_name"

> To remove the container, run command "docker rm container_name"

> To remove image, run command "docker rmi image_name"

So, after launching the container, hit the URL http://YOUR-SERVER-NAME:8080

![Alt text](https://github.com/webkul/Docker_wordpress/blob/master/Screenshot%20from%202016-12-29%2018:58:52.png?raw=true)

Now begin with the installation !!!
