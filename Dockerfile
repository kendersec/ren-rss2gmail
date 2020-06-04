FROM alpine:3.6
LABEL maintainer David Martinez <kendersec@gmail.com>

RUN apk -v --update add bash python2 wget ca-certificates && \
    rm /var/cache/apk/* && \
    update-ca-certificates && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install --upgrade pip setuptools feedparser && \
    rm -r /root/.cache

RUN GOCROND_VERSION=0.6.1 &&\
    wget --no-check-certificate -O /usr/local/bin/go-crond https://github.com/webdevops/go-crond/releases/download/$GOCROND_VERSION/go-crond-64-linux &&\
    chmod +x /usr/local/bin/go-crond

RUN rm /etc/crontabs/root

COPY . /opt/rss2gmail

RUN chmod a+x /opt/rss2gmail/ren-rss2gmail.py

VOLUME /app-data

ENTRYPOINT /opt/rss2gmail/start.sh
