# docker-ossfs

Docker Image for OSSFS based on Alpine Linux.

This image **CANNOT** be used under macOS.

## Build

```shell
docker build -t sunshow/ossfs:latest .
```

## Run

```shell
docker run -itd --cap-add SYS_ADMIN --device /dev/fuse \
  -e OSS_URL=http://oss-cn-beijing.aliyuncs.com \
  -e OSS_BUCKET=my-bucket \
  -e ACCESS_KEY_ID=LTXXXXX \
  -e ACCESS_KEY_SECRET=XXXXX \
  -e MNT_UID=`id -u` \
  -e MNT_GID=`id -g` \
  --security-opt apparmor:unconfined \
  -v ${PWD}/data:/data/ossfs:rshared \
  --name ossfs-data \
  sunshow/ossfs
```

## Reference
[使用 OSSFS 将 OSS 存储桶挂载到 ECS 实例的本地目录](https://help.aliyun.com/zh/oss/developer-reference/use-ossfs-to-mount-an-oss-bucket-to-the-local-directories-of-an-ecs-instance/#concept-kkp-lmb-wdb)

