FROM ubuntu:18.04

LABEL version="0.1"
LABEL description="LAMP Server"

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_SERVER_NAME localhost
ENV DEBIAN_FRONTEND noninteractive
ENV MARIADB_ROOT_PASSWORD root-pw
ENV MARIADB_DATABASE yiidb

RUN  apt-get update \
#  && apt-get install -y wget \
  && apt-get install -y software-properties-common \
  && apt-get install -y gnupg2 \
  && apt-get install -y zip \
  && apt-get install -y nano \
  && apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 \
  && add-apt-repository "deb [arch=amd64,arm64,ppc64el] https://archive.mariadb.org/mariadb-10.4.10/repo/ubuntu/ $(lsb_release -cs) main" \
  && apt-get install -y mariadb-server \
  && mkdir /var/run/mysqld \
  && mkfifo /var/run/mysqld/mysqld.sock \
  && chown -R mysql /var/run/mysqld \
  && apt-get install -y apache2 \
  && a2enmod rewrite \
  && add-apt-repository -y ppa:ondrej/php \
  && apt-get install -y php7.3 php7.3-mbstring php7.3-curl php7.3-xml \
#  && apt-get install -y git \
#  && git clone https://github.com/yiisoft/yii2-app-basic.git /var/www/html/basic \
  && php -r "copy('https://getcomposer.org/installer', '/var/www/html/composer-setup.php');" \
  && php /var/www/html/composer-setup.php \
  && php -r "unlink('/var/www/html/composer-setup.php');" \
  && mv composer.phar /usr/local/bin/composer \
  && composer create-project --prefer-dist yiisoft/yii2-app-basic /var/www/html/basic \
#  && rm -rf /var/lib/apt/lists/* \
  && echo "end install"

#COPY apache-conf /etc/apache2/apache2.conf
COPY phpinfo.php /var/www/html/
COPY services-up.sh services-up.sh

EXPOSE 80
EXPOSE 3306

#CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
#CMD exec mysqld_safe && /usr/sbin/apache2ctl -DFOREGROUND
CMD exec ./services-up.sh
