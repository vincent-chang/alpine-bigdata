FROM vincentzczhang/hive:1.2.1-mysql

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV HADOOP_VERSION=2.5.2
ENV SCALA_VERSION=2.10.4
ENV SPARK_VERSION=1.6.1
ENV SPARK_HIVE_VERSION=1.2.1.spark

ENV SCALA_URL=https://scala-lang.org/files/archive/scala-${SCALA_VERSION}.tgz
ENV SPARK_URL=https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}.tgz

COPY build_spark.sh /root/

RUN apk add --no-progress --no-cache nss coreutils \
    && set -x \
    && chmod +x /root/*.sh \
    && curl -fSL "${SCALA_URL}" -o /tmp/scala.tgz \
    && tar -xvf /tmp/scala.tgz -C /opt/ \
    && chown -R root:root /opt/scala-${SCALA_VERSION} \
    && rm /tmp/scala.tgz* \
    && curl -fSL "${SPARK_URL}" -o /tmp/spark.tar.gz \
    && tar -xvf /tmp/spark.tar.gz -C /opt/ \
    && chown -R root:root /opt/spark-${SPARK_VERSION} \
    && rm /tmp/spark.tar.gz* \
    && export SPARK_HOME=/opt/spark-${SPARK_VERSION} \
    && curl -fSL "https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz" -o /tmp/apache-maven-3.6.3-bin.tar.gz \
    && tar -xvf /tmp/apache-maven-3.6.3-bin.tar.gz -C /opt/ \
    && rm /tmp/apache-maven-3.6.3-bin.tar.gz \
    && chmod a+x /root/build_spark.sh

ENV MAVEN_HOME=/opt/apache-maven-3.6.3
ENV PATH=${MAVEN_HOME}/bin:$PATH
ENV SCALA_HOME=/opt/scala-${SCALA_VERSION}
ENV PATH=${SCALA_HOME}/bin:$PATH
ENV SPARK_HOME=/opt/spark-${SPARK_VERSION}

# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1

CMD ["/root/build_spark.sh"]