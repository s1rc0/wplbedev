FROM centos:7.2.1511
MAINTAINER Sergey Postument <sergey.postument@gmail.com>

RUN yum update -y
RUN yum install --nogpgcheck http://rpms.famillecollet.com/enterprise/remi-release-7.rpm -y

### Postgres
RUN yum install -y https://download.postgresql.org/pub/repos/yum/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-2.noarch.rpm
RUN yum install wget java-1.8.0-openjdk.x86_64 \
	postgresql94-server \
	postgresql94 \
	postgresql94-contrib \
	postgresql94-plperl \
	postgresql94-devel \
	-y --nogpgcheck

ADD ./postgresql94-setup /usr/pgsql-9.4/bin/postgresql94-setup
RUN chown -R postgres.postgres /var/lib/pgsql
RUN chmod +x /usr/pgsql-9.4/bin/postgresql94-setup
RUN sh /usr/pgsql-9.4/bin/postgresql94-setup initdb
ADD ./postgresql.conf /var/lib/pgsql/9.4/data/postgresql.conf
ADD ./pg_hba.conf /var/lib/pgsql/9.4/data/pg_hba.conf
ADD ./start_postgres.sh /start_postgres.sh
RUN chmod +x /start_postgres.sh
EXPOSE 5432
#CMD ["/start_postgres.sh"]

### Erlang
RUN rpm -Uvh http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
RUN yum install erlang -y 

###  Oracle JAVA 8
#RUN  wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u72-b15/jdk-8u72-linux-x64.tar.gz"
#RUN tar xzf jdk-8u72-linux-x64.tar.gz

#ADD docker/supervisord.conf /etc/supervisord.conf
COPY docker/docker-entrypoint.sh /
#RUN chmod 777 /docker-entrypoint.sh

CMD ["/start_postgres.sh"]
