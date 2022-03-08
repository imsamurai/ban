FROM alpine

WORKDIR /service/

ADD . .

RUN apk add --no-cache tor bash proxychains-ng curl findutils jq \
    && cp /etc/tor/torrc.sample /etc/tor/torrc \
    #&& sed -i 's/#chain_len/chain_len/' /etc/proxychains/proxychains.conf \
    && sed -i 's/#quiet_mode/quiet_mode/' /etc/proxychains/proxychains.conf \
    #&& sed -i 's/tcp_read_time_out 15000/tcp_read_time_out 1000/' /etc/proxychains/proxychains.conf \
    #&& sed -i 's/tcp_connect_time_out 8000/tcp_connect_time_out 500/' /etc/proxychains/proxychains.conf \
    && sed -i 's/#dynamic_chain/dynamic_chain/' /etc/proxychains/proxychains.conf \
    && chmod +x /service/docker-entrypoint.sh  \
    && chmod +x /service/run.sh \
    && chown -R root:root /var/lib/tor


ENTRYPOINT ["/service/docker-entrypoint.sh"]
