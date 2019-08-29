FROM python:2-alpine
MAINTAINER Johan Swetzén

ENV MQTT_SERVER mqtt

COPY config.ini.tmpl /config.ini.tmpl
RUN apk add --no-cache git gettext && \
    pip install paho-mqtt && \
    git clone https://github.com/dpoulson/ginlong-mqtt.git && \
    envsubst < /config.ini.tmpl > /ginlong-mqtt/config.ini && \
    apk del gettext

WORKDIR /ginlong-mqtt

ENTRYPOINT ["python", "ginlong-listen.py"]
