FROM klokantech/gdal:1.11

RUN apt-get update

RUN apt-get install -y curl

RUN apt-get clean

COPY consume.sh /consume.sh

RUN chmod +x /consume.sh

VOLUME /data

WORKDIR /

CMD ["./consume.sh"]
