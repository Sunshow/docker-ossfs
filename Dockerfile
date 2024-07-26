FROM alpine:3.20 AS builder
ENV OSSFS_VERSION 1.91.1
RUN apk --update add fuse alpine-sdk automake autoconf libxml2-dev fuse-dev curl-dev
RUN wget -qO- https://github.com/aliyun/ossfs/archive/refs/tags/v${OSSFS_VERSION}.tar.gz |tar xz
RUN cd ossfs-${OSSFS_VERSION} \
  && sed -i '/#include <fcntl.h>/a\ 
\#include <stdint.h>' src/common.h \  
&& ./autogen.sh \
  && ./configure --prefix=/usr \
  && make \
  && make install

FROM alpine:3.20
RUN apk --update add fuse curl libxml2 openssl libstdc++ libgcc && rm -rf /var/cache/apk/* 
COPY --from=builder /usr/bin/ossfs /usr/bin/ossfs
COPY mount.sh .
ENV OSS_URL=''
ENV OSS_BUCKET=''
ENV MNT_POINT=/data/ossfs
ENV MNT_UID=1000
ENV MNT_GID=1000
ENV ACCESS_KEY_ID=''
ENV ACCESS_KEY_SECRET=''

ENV OSSFS_OPTIONS='-oallow_other -omp_umask=022'
CMD ["/mount.sh"]