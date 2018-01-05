FROM hashicorp/packer:light

RUN apk add --no-cache --virtual .run-deps \
       python2 \
    && apk add --no-cache --virtual .build-deps \
        py-setuptools \
    && easy_install-2.7 pip \
    && pip install awscli \
    && apk --purge del .build-deps \
    && rm -rf /var/cache/apk /root/.cache \
    && adduser -D packer

USER packer
ENV USER=packer
ENV HOME=/home/packer
WORKDIR /home/packer
COPY packer.json .
COPY build.sh .
ENTRYPOINT
CMD ./build.sh