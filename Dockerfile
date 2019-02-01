# Build Ngind in a stock Go builder container
FROM golang:1.11-alpine as builder

RUN apk add --no-cache make gcc musl-dev git linux-headers

ADD . /ngind
RUN cd /ngind && make build_ngind

# Pull Ngind into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /ngind/bin/ngind /usr/local/bin/

EXPOSE 52520 52521 52522
CMD ["ngind"]