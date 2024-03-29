FROM golang:latest as build-stage

WORKDIR /app
COPY . .
RUN go mod download
RUN go build

FROM debian:buster-slim as production-stage
RUN apt update && DEBIAN_FRONTEND=noninteractive apt full-upgrade -y && \
apt install -y dumb-init iputils-ping curl procps

RUN mkdir /opt/symbank
COPY --from=build-stage /app/envoy-jwt-auth-helper /opt/symbank
ENTRYPOINT ["/usr/bin/dumb-init", "/opt/symbank/envoy-jwt-auth-helper"]
CMD []
