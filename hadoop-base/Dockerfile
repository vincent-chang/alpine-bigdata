FROM vincentzczhang/alpine-jdk-1.8

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV HADOOP_VERSION 2.5.2
ENV HADOOP_URL https://archive.apache.org/dist/hadoop/core/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz

ADD entry_point.sh /root/
RUN apk add --no-progress --no-cache libc6-compat perl \
    && set -x \
    && curl -fSL "${HADOOP_URL}" -o /tmp/hadoop.tar.gz \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && chown -R root:root /opt/hadoop-${HADOOP_VERSION} \
    && rm /tmp/hadoop.tar.gz* \
    && ln -s /opt/hadoop-${HADOOP_VERSION}/etc/hadoop /etc/hadoop \
    && mkdir /opt/hadoop-${HADOOP_VERSION}/logs \
    && mkdir -p /var/hadoop-data \
    && chmod a+x /root/entry_point.sh

ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH=${HADOOP_HOME}/bin/:$PATH

COPY leveldbjni-all-1.8.jar ${HADOOP_HOME}/share/hadoop/mapreduce/lib/
COPY leveldbjni-all-1.8.jar ${HADOOP_HOME}/share/hadoop/yarn/lib/

ENTRYPOINT ["bash", "/root/entry_point.sh"]
CMD ["bash"]