docker buildx build --platform linux/amd64,linux/arm64 -t vincentzczhang/spark-base:hadoop-2.5.2-hive-1.2.1-spark-1.6.1 --network host --push .