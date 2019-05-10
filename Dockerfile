FROM alpine:3.7

ARG AWS_S3_STORAGE_CLASS=STANDARD
ENV AWS_S3_STORAGE_CLASS=${AWS_S3_STORAGE_CLASS}

RUN apk upgrade --no-cache \
    && apk add --no-cache \
        groff \
        less \
        mailcap \
        postgresql-client \
        py-pip \
        python && \
    pip install --upgrade awscli==1.14.5 s3cmd==2.0.1 python-magic && \
    apk -v --purge del py-pip

RUN pg_dump --version | grep "pg_dump.*10"

COPY backup upload /usr/local/bin/
RUN cd /usr/local/bin && chmod +x backup upload

ENTRYPOINT ["backup"]
