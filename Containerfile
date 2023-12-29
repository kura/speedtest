FROM alpine:latest AS base
RUN apk add --no-cache curl && \
    curl -sL $(curl -s https://api.github.com/repos/showwin/speedtest-go/releases/latest | \
                 grep browser_download_url | \
                 cut -d\" -f4 | \
                 egrep 'Linux_x86_64.tar.gz') | \
    tar zx
COPY ./speedtest.sh .
RUN chmod 0755 ./speedtest.sh ./speedtest-go

FROM alpine:latest
RUN apk add --no-cache bash curl jq
COPY --from=base /speedtest-go /usr/bin/speedtest-go
COPY --from=base /speedtest.sh /speedtest.sh
ENTRYPOINT ["./speedtest.sh"]
