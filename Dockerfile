# Smallest base image, latests stable image
# Alpine would be nice, but it's linked again musl and breaks the kylacoin core download binary
#FROM alpine:latest

FROM ubuntu:latest AS builder

# Testing: gosu
#RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories \
#    && apk add --update --no-cache gnupg gosu gcompat libgcc
RUN apt update \
    && apt install -y --no-install-recommends \
    ca-certificates \
    gnupg \
    libatomic1 \
    wget \
    && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG VERSION=1.4.0

RUN cd /tmp \
    && mkdir -p /opt/kylacoin/bin \
    && wget https://github.com/kylacoin/kylacoin/releases/download/v${VERSION}/kylacoin-${VERSION}-linux64.tar.gz \
    && tar -xzvf kylacoin-${VERSION}-linux64.tar.gz -C /opt/kylacoin/bin \
    && ln -sv kylacoin-${VERSION} /opt/kylacoin \
    && rm -v /opt/kylacoin/bin/kylacoin-qt

FROM ubuntu:latest
LABEL maintainer="Kylacoin Developers <info@kylacoin.com>"

ENTRYPOINT ["docker-entrypoint.sh"]
ENV HOME /kylacoin
EXPOSE 5110 5111
VOLUME ["/kylacoin/.kylacoin"]
WORKDIR /kylacoin

ARG GROUP_ID=1000
ARG USER_ID=1000
RUN groupadd -g ${GROUP_ID} kylacoin \
    && useradd -u ${USER_ID} -g kylacoin -d /kylacoin kylacoin

COPY --from=builder /opt/ /opt/

RUN apt update \
    && apt install -y --no-install-recommends gosu libatomic1 \
    && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && ln -sv /opt/kylacoin/bin/* /usr/local/bin

COPY ./bin ./docker-entrypoint.sh /usr/local/bin/

CMD ["kcn_oneshot"]
