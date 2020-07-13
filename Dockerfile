FROM alpine
WORKDIR /workdir

RUN apk add wget util-linux
COPY buildscript.sh .
CMD ["sh", "-c", "./buildscript.sh"]
