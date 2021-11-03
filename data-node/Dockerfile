FROM vincentzczhang/hadoop-base:hadoop-2.5.2

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

HEALTHCHECK CMD curl -f http://localhost:9864/ || exit 1

ENV HDFS_CONF_dfs_datanode_data_dir=file:///var/hadoop/dfs/data
RUN mkdir -p /var/hadoop/dfs/data
VOLUME /var/hadoop/dfs/data

ADD run.sh /root/run.sh
RUN chmod a+x /root/run.sh

EXPOSE 9864

CMD ["/root/run.sh"]