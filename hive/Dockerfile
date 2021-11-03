FROM vincentzczhang/hadoop-base:hadoop-2.5.2

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

ENV HADOOP_VERSION=2.5.2
# Allow buildtime config of HIVE_VERSION
ARG HIVE_VERSION
# Set HIVE_VERSION from arg if provided at build, env if provided at run, or default
# https://docs.docker.com/engine/reference/builder/#using-arg-variables
# https://docs.docker.com/engine/reference/builder/#environment-replacement
ENV HIVE_VERSION=${HIVE_VERSION:-1.2.1}

ENV HIVE_HOME=/opt/hive
ENV PATH=$HIVE_HOME/bin:$PATH

WORKDIR /opt

#Install Hive and MariaDB JDBC
RUN apk add --no-progress --no-cache procps && \
	wget https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz && \
	tar -xzvf apache-hive-$HIVE_VERSION-bin.tar.gz && \
	mv apache-hive-$HIVE_VERSION-bin hive && \
	wget https://downloads.mariadb.com/Connectors/java/connector-java-2.7.3/mariadb-java-client-2.7.3.jar -O $HIVE_HOME/lib/mariadb-java-client-2.7.3.jar && \
	rm apache-hive-$HIVE_VERSION-bin.tar.gz && \
	rm /opt/hadoop-${HADOOP_VERSION}/share/hadoop/yarn/lib/jline-*.jar && \
	cp /opt/hive/lib/jline-*.jar /opt/hadoop-${HADOOP_VERSION}/share/hadoop/yarn/lib/

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

COPY startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

COPY entry_point.sh /root/entry_point.sh
RUN chmod +x /root/entry_point.sh

EXPOSE 10000
EXPOSE 10002

ENTRYPOINT ["/root/entry_point.sh"]
CMD /root/startup.sh
