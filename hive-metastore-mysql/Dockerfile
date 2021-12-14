FROM alpine:3.14

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=hive
ENV MYSQL_USER=hive
ENV MYSQL_PASSWORD=hive

RUN apk add --no-progress --no-cache bash mysql mysql-client
COPY my.cnf /etc/my.cnf
COPY hive-schema.mysql.sql /tmp/
COPY hive-txn-schema.mysql.sql /tmp/
COPY docker-entrypoint.sh /root/
RUN chmod a+x /root/docker-entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/root/docker-entrypoint.sh"]