docker buildx build --platform linux/amd64,linux/arm64 -t vincentzczhang/name-node:hadoop-2.5.2 --network host --push .