FROM vincentzczhang/hadoop-base:hadoop-2.5.2

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV HADOOP_VERSION=2.5.2
ARG HIVE_VERSION
ENV HIVE_VERSION=${HIVE_VERSION:-1.2.1}

ENV HIVE_HOME=/opt/hive
ENV PATH=$HIVE_HOME/bin:$PATH

ENV HADOOP_YARN_LIB_DIR=${HADOOP_HOME}/share/hadoop/yarn/lib
ENV HIVE_METASTORE_JDBC_DRIVER=${HIVE_HOME}/lib/mariadb-java-client-2.7.3.jar

COPY startup.sh /root/
COPY entry_point.sh /root/

WORKDIR /opt

#Install Hive and MariaDB JDBC
RUN apk add --no-progress --no-cache procps && \
	wget https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz && \
	tar -xzvf apache-hive-$HIVE_VERSION-bin.tar.gz && \
	mv apache-hive-$HIVE_VERSION-bin hive && \
	wget https://downloads.mariadb.com/Connectors/java/connector-java-2.7.3/mariadb-java-client-2.7.3.jar -O $HIVE_HOME/lib/mariadb-java-client-2.7.3.jar && \
	rm apache-hive-$HIVE_VERSION-bin.tar.gz && \
	rm /opt/hadoop-${HADOOP_VERSION}/share/hadoop/yarn/lib/jline-*.jar && \
	cp /opt/hive/lib/jline-*.jar /opt/hadoop-${HADOOP_VERSION}/share/hadoop/yarn/lib/ && \
	rm -f ${HADOOP_YARN_LIB_DIR}/datanucleus-*.jar && \
    cp ${HIVE_HOME}/lib/datanucleus-*.jar ${HADOOP_YARN_LIB_DIR}/ && \
    cp ${HIVE_METASTORE_JDBC_DRIVER} ${HADOOP_YARN_LIB_DIR}/ && \
	chmod +x /root/startup.sh && \
	chmod +x /root/entry_point.sh

#Spark should be compiled with Hive to be able to use it
#hive-site.xml should be copied to $SPARK_HOME/conf folder

#Custom configuration goes here
ADD conf/hive-site.xml $HIVE_HOME/conf
ADD conf/beeline-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-env.sh $HIVE_HOME/conf
ADD conf/hive-exec-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-log4j2.properties $HIVE_HOME/conf
ADD conf/ivysettings.xml $HIVE_HOME/conf
ADD conf/llap-daemon-log4j2.properties $HIVE_HOME/conf

EXPOSE 10000
EXPOSE 10002

CMD ["/root/startup.sh"]