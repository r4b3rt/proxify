# Base
FROM golang:1.17.3-alpine AS builder

RUN apk add --no-cache git
RUN go install -v github.com/projectdiscovery/proxify/cmd/proxify@latest

FROM alpine:3.14
RUN apk -U upgrade --no-cache \
    && apk add --no-cache bind-tools ca-certificates
COPY --from=builder /go/bin/proxify /usr/local/bin/

ENTRYPOINT ["proxify"]
