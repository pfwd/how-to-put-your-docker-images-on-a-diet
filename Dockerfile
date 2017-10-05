# Heavy weight Dockerfile
# Built from many Docker image layers
# Files size: 314MB (At time of creating talk)

FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

ENV DOC_ROOT /var/www/mysite

RUN apt-get update -y \
    && \
        apt-get install -y \
            apache2 \
            libapache2-mod-php \
            php7.0 php7.0-cli php7.0-xml \
    && \
        a2enmod rewrite

ADD config/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf

WORKDIR ${DOC_ROOT}

COPY site .

RUN chown -R www-data:www-data var

EXPOSE 80

CMD apachectl -D FOREGROUND