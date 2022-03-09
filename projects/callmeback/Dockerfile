FROM alpine

WORKDIR /service/

ADD . .

RUN apk add --no-cache tor bash proxychains-ng curl findutils jq \
    && cp /etc/tor/torrc.sample /etc/tor/torrc \
    && echo 'ExitNodes {ru},{by}' >> /etc/tor/torrc \
    && echo 'StrictNodes 1' >> /etc/tor/torrc \
    && sed -i 's/#chain_len = 2/chain_len = 1/' /etc/proxychains/proxychains.conf \
    #&& sed -i 's/#quiet_mode/quiet_mode/' /etc/proxychains/proxychains.conf \
#    && sed -i 's/tcp_read_time_out 15000/tcp_read_time_out 2000/' /etc/proxychains/proxychains.conf \
#    && sed -i 's/tcp_connect_time_out 8000/tcp_connect_time_out 2000/' /etc/proxychains/proxychains.conf \
    && sed -i 's/strict_chain/#strict_chain/' /etc/proxychains/proxychains.conf \
    && sed -i 's/#random_chain/random_chain/' /etc/proxychains/proxychains.conf \
    && chmod +x /service/docker-entrypoint.sh  \
    && chmod +x /service/bitrix.sh \
    && chown -R root:root /var/lib/tor


ENTRYPOINT ["/service/docker-entrypoint.sh"]
