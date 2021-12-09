#!/bin/bash
set -x
set -e
if [ ! -f "/opt/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz" ]; then
  cd ${SPARK_HOME}
  ./make-distribution.sh --tgz -Pyarn -Dhadoop.version=${HADOOP_VERSION} -Phive -Dhive.version=${SPARK_HIVE_VERSION}
  if [ -f "${SPARK_HOME}/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz" ]; then
    mv ${SPARK_HOME}/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz /opt/
    rm -rf ${SPARK_HOME}
    tar -xvf /opt/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz -C /opt/
    rm /opt/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz
    mv /opt/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION} ${SPARK_HOME}
    rm -rf /root/.m2
    rm -rf ${MAVEN_HOME}
    cd ${SPARK_HOME}/conf
    ln -s ${HIVE_HOME}/conf/hive-site.xml hive-site.xml
    rm -f ${HADOOP_YARN_LIB_DIR}/datanucleus-*.jar
    cp ${HIVE_HOME}/lib/datanucleus-*.jar ${HADOOP_YARN_LIB_DIR}/
    cp ${HIVE_METASTORE_JDBC_DRIVER} ${HADOOP_YARN_LIB_DIR}/
    cp ${SPARK_HOME}/lib/spark-${SPARK_VERSION}-yarn-shuffle.jar ${HADOOP_YARN_LIB_DIR}/
    rm -f /opt/spark-${SPARK_VERSION}/lib/datanucleus-*.jar
    cp ${HIVE_HOME}/lib/datanucleus-*.jar /opt/spark-${SPARK_VERSION}/lib/
    rm /root/build-spark.sh
  fi
fi