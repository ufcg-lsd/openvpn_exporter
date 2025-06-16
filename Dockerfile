FROM golang:1.24.4-bullseye AS builder

WORKDIR /app

COPY . .

RUN make build

FROM golang:1.24.4-bullseye AS runner

ENV OPENVPN_EXPORTER_STATUS_FILE=${OPENVPN_EXPORTER_STATUS_FILE} \
    OPENVPN_EXPORTER_WEB_ADDRESS=${OPENVPN_EXPORTER_WEB_ADDRESS}

COPY --from=builder /app/bin/openvpn_exporter /usr/bin/

ENTRYPOINT ["openvpn_exporter"]
