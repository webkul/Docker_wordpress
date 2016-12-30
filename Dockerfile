From ubuntu:14.04

MAINTAINER Alankrit Srivastava alankrit.srivastava256@webkul.com

##update server

RUN apt-get update

##install apache2

RUN apt-get -y install apache2

RUN mkdir -p /var/lock/apache2 /var/run/apache2

#add repository and install php7.0

RUN locale-gen en_US.UTF-8 \
	&& export LANG=en_US.UTF-8 \
	&& apt-get update \
	&& apt-get install -y software-properties-common \
	&& apt-get install -y language-pack-en-base \
	&& LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php \
	&& apt-get update \
        && apt-get install -y python-software-properties \
        && apt-get -y install php7.0 php7.0-curl php7.0-intl php7.0-gd php7.0-dom php7.0-mcrypt php7.0-iconv php7.0-xsl php7.0-mbstring php7.0-ctype php7.0-zip php7.0-pdo php7.0-xml php7.0-bz2 php7.0-calendar php7.0-exif php7.0-fileinfo php7.0-json php7.0-mysqli php7.0-mysql php7.0-posix php7.0-tokenizer php7.0-xmlwriter php7.0-xmlreader php7.0-phar php7.0-soap php7.0-mysql php7.0-fpm libapache2-mod-php7.0

## manage php memory and date-timezone settings

RUN sed -i -e"s/^memory_limit\s*=\s*128M/memory_limit = 768M/" /etc/php/7.0/apache2/php.ini

RUN echo "date.timezone = Asia/Kolkata" >> /etc/php/7.0/apache2/php.ini

RUN echo "date.timezone = Asia/Kolkata" >> /etc/php/7.0/cli/php.ini

##download and install wordpress

RUN apt-get install -y wget

RUN cd /var/www/ && wget https://wordpress.org/latest.zip

RUN apt-get install -y zip

RUN cd /var/www/ && unzip latest.zip

COPY wp-config.php /var/www/wordpress/wp-config.php

RUN chown -R www-data:www-data /var/www/wordpress/

RUN find /var/www/wordpress -type f -exec chmod 644 {} \;

RUN find /var/www/wordpress -type d -exec chmod 755 {} \;

##apache2 settings

COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN a2enmod php7.0

RUN a2enmod rewrite

RUN a2enmod headers

##install mysql-server

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server-5.6

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

RUN touch /var/run/mysqld/mysqld.sock

RUN touch /var/run/mysqld/mysqld.pid

RUN chown -R mysql:mysql /var/run/mysqld/mysqld.sock

RUN chown -R mysql:mysql /var/run/mysqld/mysqld.pid

RUN chmod -R 644 /var/run/mysqld/mysqld.sock

RUN chmod -R 644 /var/run/mysqld/mysqld.pid

##generate random password for database

RUN cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1 >> /etc/flag

##install nano

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nano

##install supervisor

RUN apt-get install -y supervisor

RUN mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

##setup test.sh script

COPY test.sh /etc/test.sh

RUN chmod a+x /etc/test.sh

## setup mysql.sh script 
 
COPY mysql.sh /etc/mysql.sh

RUN chmod a+x /etc/mysql.sh

RUN /etc/init.d/mysql restart

RUN /etc/init.d/apache2 restart

EXPOSE 3306

EXPOSE 80

CMD ["/usr/bin/supervisord"]

