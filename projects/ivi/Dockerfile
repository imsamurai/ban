FROM node:16-alpine

WORKDIR /node/

ADD . .

RUN apk add --no-cache tor bash proxychains-ng curl findutils jq \
    && cp /etc/tor/torrc.sample /etc/tor/torrc \
    && sed -i 's/#quiet_mode/quiet_mode/' /etc/proxychains/proxychains.conf \
    && sed -i 's/#dynamic_chain/dynamic_chain/' /etc/proxychains/proxychains.conf \
    && chmod +x /node/docker-entrypoint.sh  \
    && chmod +x /node/ivi.sh \
    && chown -R root:root /var/lib/tor


ENTRYPOINT ["/node/docker-entrypoint.sh"]
