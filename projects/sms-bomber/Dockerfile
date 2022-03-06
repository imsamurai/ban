FROM python:3.9-alpine3.14

WORKDIR /app/

ADD . .

RUN apk add --no-cache tor bash proxychains-ng \
    && cp /etc/tor/torrc.sample /etc/tor/torrc \
    && sed -i 's/^#ControlPort.*/ControlPort 9051/g' /etc/tor/torrc \
    && sed -i 's/#quiet_mode/quiet_mode/' /etc/proxychains/proxychains.conf \
    && sed -i 's/#random_chain/random_chain/' /etc/proxychains/proxychains.conf \
    && chmod +x /app/docker-entrypoint.sh  \
    && chown -R root:root /var/lib/tor \
    && pip3 install -r requirements.txt

ENTRYPOINT ["/app/docker-entrypoint.sh"]
