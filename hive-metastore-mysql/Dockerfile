FROM mariadb:latest

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=hive
ENV MYSQL_USER=hive
ENV MYSQL_PASSWORD=hive

ADD 50-mysqld.cnf /etc/mysql/conf.d/
ADD hive-schema.mysql.sql /tmp/
ADD hive-txn-schema.mysql.sql /tmp/
ADD init_hive_db.sh /docker-entrypoint-initdb.d/
RUN chmod a+x /docker-entrypoint-initdb.d/init_hive_db.sh

EXPOSE 3306