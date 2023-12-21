FROM alpine:latest

RUN apk add --no-cache \
        g++ \
        cmake make \
        curl curl-dev \
        libxml2-dev \
        openssl-dev \
        git \
        bash \
        jq && \
    git clone https://github.com/taganaka/SpeedTest && \
    cd SpeedTest && \
    cmake -DCMAKE_BUILD_TYPE=Release . && \
    make install

RUN rm -rf SpeedTest

COPY ./speedtest.sh .

RUN chmod 0755 ./speedtest.sh

CMD ["./speedtest.sh"]
