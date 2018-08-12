FROM ubuntu:latest

MAINTAINER Name<email>

#ENV myDockerMysqlPassword root

ENV DEBIAN_FRONTEND noninteractive

# Install basics
RUN apt-get update
RUN apt-get install -y software-properties-common && add-apt-repository ppa:ondrej/php && apt-get update
RUN apt-get install -y curl

# Install mysql
#RUN debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
#RUN debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
##RUN apt-get install -y mysql-server-5.6
#RUN apt-get install -y mysql-server-5.7

## Install PHP 5.6
#RUN apt-get install -y --allow-unauthenticated php5.6 php5.6-mysql php5.6-mcrypt php5.6-cli php5.6-gd php5.6-curl
#
## Enable apache mods.
#RUN a2enmod php5.6
#RUN a2enmod rewrite

# Install PHP 7.0
#sudo add-apt-repository ppa:ondrej/php
#sudo apt-get -y update
RUN apt-get -y install php7.0 php7.0-mcrypt php7.0-mbstring php7.0-curl php7.0-cli php7.0-mysql php7.0-gd php7.0-intl \
php7.0-xsl php7.0-zip php7.0-bcmath php7.0-soap git

# Enable apache mods.
RUN a2enmod php7.0
RUN a2enmod rewrite

## Update the PHP.ini file, enable <? ?> tags and quieten logging.
#RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/5.6/apache2/php.ini
#RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/5.6/apache2/php.ini
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.0/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.0/apache2/php.ini


# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php
RUN cp composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

# Manually set up the apache environment variables
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Expose apache.
EXPOSE 80
EXPOSE 8080
EXPOSE 443
EXPOSE 3306

# Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND

VOLUME /var/log