FROM alpine:3.6

ENV VER=2.11.1 METHOD=chacha20 PASSWORD=ss123456 PROTOCOL=ss+mws
ENV TLS_PORT=4433 PORT=8080

RUN apk add --no-cache curl \
  && curl -sL https://github.com/ginuerzh/gost/releases/download/v${VER}/gost-linux-amd64-${VER}.gz | gzip -d \
  && mv gost-linux-amd64 gost && chmod a+x gost/gost

WORKDIR /
EXPOSE ${TLS_PORT} $PORT $PASSWORD $METHOD $PROTOCOL

CMD exec /gost -L=tls://:${TLS_PORT}/:$PORT -L=$PROTOCOL://$METHOD:$PASSWORD@:$PORT

