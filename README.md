# Alpine Linux arm64 平台下的大数据 Dockers

此项目是以 https://github.com/big-data-europe 作为基础所做的 Alpine Linux arm64 平台定制开发。

## 项目目标
建立一套可以运行在 Apple Silicon M1 机器上的大数据 Docker 镜像。

![image](https://github.com/vincent-chang/alpine-bigdata/blob/main/.image/alpine-bigdata-docker.png?raw=true)

## Docker Hub
https://hub.docker.com/u/vincentzczhang

## 模块说明：
* hadoop-base: 基础的 hadoop 环境，由于原版 yarn 中的 leveldbjni-all-1.8 并不能用在 Alpine Linux 上，所以我把它在 Alpine 上重新编译打包了。
* name-node: 顾名思义
* data-node: 顾名思义
* resource-manager: 顾名思义
* node-manager: 顾名思义
* node-manager-spark-shuffle: 在 yarn 中配置了 spark-shuffle 的 node-manager
* hadoop-history-server: 顾名思义
* hive: hive server 服务
* hive-metastore-mysql: hive metastore 服务和 mariadb 数据库 
* spark-build: spark 的编译打包测试环境，不再 docker-compose 中启动的。
* spark-base: spark 的基础运行环境。
* spark-master: 顾名思义
* spark-worker: 顾名思义
* spark-history-server: 顾名思义

当前可用的组件版本： hadoop-2.5.2, hive-1.2.1, spark-1.6.1
