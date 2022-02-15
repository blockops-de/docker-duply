FROM alpine:latest

LABEL maintainer="Fabian Schuh <fabian@blockops.de>"

RUN  echo 'http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk update \
    && apk add bash \
        duply \
        py-pip \
        haveged \
        ncftp \
        py-boto \
        py-paramiko \
        pwgen \
        rsync \
        openssh-client \
        mariadb-client \
    && pip install --upgrade pip

ENV HOME /root

ENV KEY_TYPE      RSA
ENV KEY_LENGTH    2048
ENV SUBKEY_TYPE   RSA
ENV SUBKEY_LENGTH 2048
ENV NAME_REAL     Duply Backup
ENV NAME_EMAIL    duply@localhost
ENV PASSPHRASE    random

VOLUME ["/root"]

COPY files/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash"]
