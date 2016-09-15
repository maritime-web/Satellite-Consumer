FROM alpine:latest

COPY consume.sh /consume.sh

RUN chmod +x /consume.sh

RUN apk update

RUN apk add bash

RUN apk add curl

RUN apk add coreutils

VOLUME /data

CMD ["./consume.sh"]
