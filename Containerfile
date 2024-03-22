FROM alpine:latest AS base
RUN apk add --no-cache curl tar && \
    curl -sL $(curl -s https://api.github.com/repos/showwin/speedtest-go/releases/latest | \
                 grep browser_download_url | \
                 cut -d\" -f4 | \
                 egrep 'Linux_x86_64.tar.gz') | \
    tar zx && \
    curl -sL https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-linux-x86_64.tgz | \
    tar xz --transform='s/$/-ookla/g' speedtest

COPY ./speedtest.sh .
RUN chmod 0755 ./speedtest.sh ./speedtest-go ./speedtest-ookla

FROM alpine:latest
RUN apk add --no-cache bash curl jq whois
COPY --from=base /speedtest-ookla /usr/bin/speedtest-ookla
COPY --from=base /speedtest-go /usr/bin/speedtest-go
COPY --from=base /speedtest.sh /speedtest.sh
ENTRYPOINT ["./speedtest.sh"]
