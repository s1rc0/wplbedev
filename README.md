## OpenJDK8 + Postgres 9.4 + Erlang 18 Container
Docker container with Java8+Erlang+Postgres stack based on Centos7

### Base Docker Image

* [centos:7.2.1511](https://hub.docker.com/_/centos/)


### Usage

    docker run -d -p 80:80 docker pull s1rc0/nginx-php-fpm

#### Attach persistent/shared directories

    docker run -d -p 80:80 -v <html-dir>:/usr/share/nginx/html s1rc0/nginx-php-fpm

After few seconds, open `http://<host>` to see the welcome page.
