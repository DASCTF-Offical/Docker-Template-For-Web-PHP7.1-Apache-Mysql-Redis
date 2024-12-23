FROM php:7.1-apache
COPY files /tmp/files/
RUN chown -R root:root /var/www/html/ && \
    chmod -R 755 /var/www/html && \
    mv /tmp/files/flag.sh / && \
    mv /tmp/files/start.sh / && \
    chmod +x /flag.sh /start.sh && \
    apt-get update && \
    apt-get install libaio1 libnuma1 psmisc libmecab2 redis-server -y && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-common_5.7.29-1debian10_amd64.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-community-client_5.7.29-1debian10_amd64.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-client_5.7.29-1debian10_amd64.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-community-server_5.7.29-1debian10_amd64.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-server_5.7.29-1debian10_amd64.deb && \
    cp -f /tmp/files/redis.conf /etc/redis/redis.conf && \
    rm -rf /tmp/files && \
    docker-php-ext-install mysqli pdo pdo_mysql && \
    pecl install redis-5.3.4 && \
    echo "extension=redis.so\n" >> /usr/local/etc/php/conf.d/docker-php-ext-redis.ini && \
    rm -rf /var/lib/apt/lists/*
CMD /start.sh
