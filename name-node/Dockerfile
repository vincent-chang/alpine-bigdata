FROM vincentzczhang/hadoop-base:hadoop-2.5.2

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

HEALTHCHECK CMD curl -f http://localhost:9870/ || exit 1

ENV HDFS_CONF_dfs_namenode_name_dir=file:///var/hadoop/dfs/name
RUN mkdir -p /var/hadoop/dfs/name
VOLUME /var/hadoop/dfs/name

ADD run.sh /root/run.sh
RUN chmod a+x /root/run.sh

EXPOSE 9870

CMD ["/root/run.sh"]