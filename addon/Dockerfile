name: "Digital Alchemy"
description: "Digital Alchemy code runner. Typescript in Home Assistant"
version: "1.0.0"
slug: "digital_alchemy"
homeassistant_api: true
hassio_role: admin
init: false
icon: mdi:crystal-ball
arch:
  - aarch64
  - amd64
  - armhf
  - armv7
  - i386
options:
  app_root: /config/digital_alchemy
  config_file: ""
  mode: deploy

schema:
  app_root: str
  config_file: str
  mode: list(deploy|run|watch)

map:
  - config:rw
