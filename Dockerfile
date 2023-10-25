FROM nginx:1.25.3-alpine3.18-slim
EXPOSE 80
RUN apk update && apk add --no-cache supervisor wget unzip curl

ENV UUID 4d25542a-9734-4e25-8c5f-ade059a0450a
ENV SVERSION 1.5.4

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir /etc/sbox /usr/local/sbox
COPY config.json /etc/sbox/
COPY entrypoint.sh /usr/local/sbox

RUN wget -q  https://github.com/SagerNet/sing-box/releases/download/v${SVERSION}/sing-box-${SVERSION}-linux-amd64.tar.gz && \
    tar xvf sing-box-${SVERSION}-linux-amd64.tar.gz -C /usr/local/sbox && \
    mv /usr/local/sbox/sing-box-${SVERSION}-linux-amd64/sing-box /usr/local/sbox/ && \
    rm -f sing-box-${SVERSION}-linux-amd64.tar.gz && \
    chmod +x /usr/local/sbox/entrypoint.sh && \
    apk del wget unzip  && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

ENTRYPOINT [ "/usr/local/sbox/entrypoint.sh" ]