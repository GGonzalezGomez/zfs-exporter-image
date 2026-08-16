# zfs-exporter-image
Image push from https://github.com/pdf/zfs_exporter

# Usage

To use the image via `docker run`:

```sh
docker run -p 9134:9134 --device /dev/zfs ggongom/zfs-exporter
```

To use the image via `docker compose`:

```yaml
name: zfs-exporter
services:
  zfs-exporter:
    ports:
      - 9134:9134
    devices:
      - /dev/zfs
    image: ggongom/zfs-exporter
    restart: unless-stopped
    container_name: zfs-exporter
```
