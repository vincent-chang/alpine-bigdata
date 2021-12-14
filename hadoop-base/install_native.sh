#!/bin/bash
native_tar_file="/tmp/alpine-hadoop-native-${HADOOP_VERSION}-`arch`.tar.gz"
echo "Native tar: ${native_tar_file}"
if [ -f "${native_tar_file}" ]; then
  tar -xvf "${native_tar_file}" -C /opt/hadoop-${HADOOP_VERSION}/lib/native/
  ln -s $HADOOP_HOME/lib/native/libhadoop.so /usr/lib/libhadoop.so
  ln -s $HADOOP_HOME/lib/native/libhdfs.so /usr/lib/libhdfs.so
else
  echo "Native tar file not found!"
fi