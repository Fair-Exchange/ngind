FROM golang:1.11-alpine

RUN apk add --no-cache git make gcc musl-dev linux-headers
RUN git clone https://github.com/Fair-Exchange/ngind /ngind
RUN cd /ngind && make static



# Pull AquaChain into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /ngind/build/bin/ngind /usr/local/bin/

EXPOSE 52520 52521 52522
CMD ["ngind"]