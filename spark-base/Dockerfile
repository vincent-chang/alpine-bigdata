FROM vincentzczhang/hive:1.2.1-mysql

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

ENV HADOOP_VERSION=2.5.2
ENV SCALA_VERSION=2.10.4
ENV SPARK_VERSION=1.6.1
ENV SPARK_HIVE_VERSION=1.2.1.spark

ENV SCALA_URL=https://scala-lang.org/files/archive/scala-${SCALA_VERSION}.tgz
ENV SPARK_URL=https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}.tgz

COPY build-spark.sh /root/
COPY wait-for-step.sh /root/
COPY execute-step.sh /root/
COPY finish-step.sh /root/

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
    && curl -fSL "https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz" -o /tmp/apache-maven-3.6.3-bin.tar.gz \
    && tar -xvf /tmp/apache-maven-3.6.3-bin.tar.gz -C /opt/ \
    && rm /tmp/apache-maven-3.6.3-bin.tar.gz \
    && chmod a+x /root/*.sh

ENV MAVEN_HOME=/opt/apache-maven-3.6.3
ENV PATH=${MAVEN_HOME}/bin:$PATH
ENV SCALA_HOME=/opt/scala-${SCALA_VERSION}
ENV PATH=${SCALA_HOME}/bin:$PATH
ENV SPARK_HOME=/opt/spark-${SPARK_VERSION}

ENV HADOOP_YARN_LIB_DIR=${HADOOP_HOME}/share/hadoop/yarn/lib
ENV HIVE_METASTORE_JDBC_DRIVER=${HIVE_HOME}/lib/mariadb-java-client-2.7.3.jar
ENV SPARK_CLASSPATH=${HIVE_METASTORE_JDBC_DRIVER}

RUN /root/build-spark.sh

# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1

CMD ["bash"]