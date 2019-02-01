FROM golang:1.11-alpine

RUN apk add --no-cache git make gcc musl-dev linux-headers
RUN git clone https://github.com/NginProject/ngind /ngind
RUN cd /ngind && make release

EXPOSE 52520 52521 52522

ENTRYPOINT ["/ngind/bin/ngind"]