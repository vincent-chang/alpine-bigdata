FROM vincentzczhang/alpine-mysql

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV HIVE_DB_NAME=hive
ENV HIVE_DB_USER=hive
ENV HIVE_DB_PASSWORD=hive

ADD hive-schema.mysql.sql /root/hive-schema.mysql.sql
ADD hive-txn-schema.mysql.sql /root/hive-txn-schema.mysql.sql
ADD init_hive_db.sh /root/init_hive_db.sh
RUN chmod a+x /root/init_hive_db.sh

EXPOSE 3306

ENTRYPOINT ["bash", "/root/init_hive_db.sh"]