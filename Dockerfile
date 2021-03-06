FROM hashicorp/packer:light

RUN apk add --no-cache --virtual .run-deps \
       python3 \
    && pip3 install awscli setuptools \
    && rm -rf /var/cache/apk /root/.cache \
    && adduser -D packer

USER packer
WORKDIR /home/packer
COPY packer.json .
COPY build.sh .
COPY scripts scripts
ENTRYPOINT
CMD ./build.sh
