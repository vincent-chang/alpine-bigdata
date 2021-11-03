FROM vincentzczhang/hive:1.2.1-mysql

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

ENV SPARK_VERSION=1.6.1
ENV SCALA_VERSION=2.10.4

ENV SCALA_URL=https://scala-lang.org/files/archive/scala-${SCALA_VERSION}.tgz
ENV SPARK_URL=https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}.tgz

ENV HADOOP_YARN_LIB_DIR=${HADOOP_HOME}/share/hadoop/yarn/lib
ENV HIVE_METASTORE_JDBC_DRIVER=${HIVE_HOME}/lib/mariadb-java-client-2.7.3.jar
ENV SPARK_CLASSPATH=${HIVE_METASTORE_JDBC_DRIVER}

COPY spark-1.6.1-bin-2.5.2.tgz /opt/
COPY wait-for-step.sh /root/
COPY execute-step.sh /root/
COPY finish-step.sh /root/

RUN apk add --no-progress --no-cache nss coreutils \
    && set -x \
    && chmod +x /root/*.sh \
    && curl -fSL "${SCALA_URL}" -o /tmp/scala.tgz \
    && tar -xvf /tmp/scala.tgz -C /opt/ \
    && chown -R root:root /opt/scala-${SCALA_VERSION} \
    && rm /tmp/scala.tgz \
    && tar -xvf /opt/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz -C /opt/ \
    && chown -R root:root /opt/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION} \
    && rm /opt/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz \
    && mv /opt/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION} /opt/spark-${SPARK_VERSION} \
    && ln -s ${HIVE_HOME}/conf/hive-site.xml hive-site.xml \
    && rm -f ${HADOOP_YARN_LIB_DIR}/datanucleus-*.jar \
    && cp ${HIVE_HOME}/lib/datanucleus-*.jar ${HADOOP_YARN_LIB_DIR}/ \
    && cp ${HIVE_METASTORE_JDBC_DRIVER} ${HADOOP_YARN_LIB_DIR}/ \
    && cp /opt/spark-${SPARK_VERSION}/lib/spark-${SPARK_VERSION}-yarn-shuffle.jar ${HADOOP_YARN_LIB_DIR}/ \
    && rm -f /opt/spark-${SPARK_VERSION}/lib/datanucleus-*.jar \
    && cp ${HIVE_HOME}/lib/datanucleus-*.jar /opt/spark-${SPARK_VERSION}/lib/

ENV SCALA_HOME=/opt/scala-${SCALA_VERSION}
ENV PATH=${SCALA_HOME}/bin:$PATH
ENV SPARK_HOME=/opt/spark-${SPARK_VERSION}
ENV PATH=${SPARK_HOME}/bin:$PATH

# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1