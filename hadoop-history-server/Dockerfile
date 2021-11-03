FROM vincentzczhang/hadoop-base:hadoop-2.5.2

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

HEALTHCHECK CMD curl -f http://localhost:8188/ || exit 1

ENV YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path=/var/hadoop/yarn/timeline
RUN mkdir -p /var/hadoop/yarn/timeline
VOLUME /var/hadoop/yarn/timeline

ADD run.sh /root/run.sh
RUN chmod a+x /root/run.sh

EXPOSE 8188

CMD ["/root/run.sh"]