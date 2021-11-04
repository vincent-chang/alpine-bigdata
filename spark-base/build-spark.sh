#!/bin/bash
if [ ! -f "/opt/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz" ]
then
  cd ${SPARK_HOME}
  ./make-distribution.sh --tgz -Pyarn -Dhadoop.version=${HADOOP_VERSION} -Phive -Dhive.version=${SPARK_HIVE_VERSION}
  mv ${SPARK_HOME}/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz /opt/
fi
bash