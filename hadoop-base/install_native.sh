#!/bin/bash
native_tar_file="/tmp/alpine-hadoop-native-${HADOOP_VERSION}-`arch`.tar.gz"
echo "Native tar: ${native_tar_file}"
if [ -f "${native_tar_file}" ]; then
  tar -xvf "${native_tar_file}" -C /opt/hadoop-${HADOOP_VERSION}/lib/native/
else
  echo "Native tar file not found!"
fi
