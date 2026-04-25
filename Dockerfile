# ETAPA 1: Construcción con Go 1.24
FROM golang:1.24-alpine AS builder

# Declaramos el argumento que recibiremos desde fuera
ARG EXPORTER_VERSION=latest

# Instalamos git para que go install pueda descargar el repo
RUN apk add --no-cache git

RUN go install github.com/pdf/zfs_exporter/v2@v$EXPORTER_VERSION

# ETAPA 2: Imagen final mínima
FROM alpine:latest

# Instalamos los binarios de ZFS (necesarios para que el exporter haga las consultas)
RUN apk add --no-cache zfs

# Copiamos solo el binario compilado desde la etapa anterior
COPY --from=builder /go/bin/zfs_exporter /usr/local/bin/zfs_exporter

EXPOSE 9134

# Configuración de ejecución
ENTRYPOINT ["/usr/local/bin/zfs_exporter"]
CMD ["--collector.dataset-volumes", "--web.disable-exporter-metrics", "--web.telemetry-path=/metrics"]
