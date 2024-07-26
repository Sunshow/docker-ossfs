#!/bin/sh
# 检查必要参数
if [ -z "${OSS_BUCKET}" ]; then
    echo "OSS_BUCKET is not set. Please provide the OSS bucket name."
    exit 1
fi
if [ -z "${OSS_URL}" ]; then
    echo "OSS_URL is not set. Please provide the OSS Url."
    exit 1
fi
if [ -z "${ACCESS_KEY_ID}" ]; then
    echo "ACCESS_KEY_ID is not set. Please provide the AccessKeyId."
    exit 1
fi
if [ -z "${ACCESS_KEY_SECRET}" ]; then
    echo "ACCESS_KEY_SECRET is not set. Please provide the AccessKeySecret."
    exit 1
fi

echo ${OSS_BUCKET}:${ACCESS_KEY_ID}:${ACCESS_KEY_SECRET} > /etc/passwd-ossfs
chmod 640 /etc/passwd-ossfs
mkdir -p ${MNT_POINT}
exec ossfs -f ${OSS_BUCKET} ${MNT_POINT} -ourl=${OSS_URL} -ouid=${MNT_UID} -ogid=${MNT_GID} ${OSSFS_OPTIONS}