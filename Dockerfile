FROM python:3.8-alpine

ARG s3cmd_url="https://sourceforge.net/projects/s3tools/files/s3cmd/2.1.0/s3cmd-2.1.0.tar.gz/download"

RUN pip install --upgrade pip \
    && pip install "${s3cmd_url}"

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

