FROM alpine:latest

COPY consume.sh /consume.sh

RUN chmod +x /consume.sh

RUN apk update

RUN apk add bash

RUN apk add curl

VOLUME /data

CMD ["./consume.sh"]
