FROM alpine:latest AS base

RUN apk add --no-cache curl bash jq && \
    curl -sL $(curl -s https://api.github.com/repos/showwin/speedtest-go/releases/latest | \
                 grep browser_download_url | \
                 cut -d\" -f4 | \
                 egrep 'Linux_x86_64.tar.gz') | \
    tar zx

COPY ./speedtest.sh .

RUN chmod 0755 ./speedtest.sh ./speedtest-go

CMD ["./speedtest.sh"]
