FROM vincentzczhang/hadoop-base:hadoop-2.5.2

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1

ADD run.sh /root/run.sh
RUN chmod a+x /root/run.sh

EXPOSE 8042

CMD ["/root/run.sh"]