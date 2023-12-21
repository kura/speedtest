FROM ubuntu:jammy

RUN apt-get update && apt-get -y install build-essential libcurl4-openssl-dev libxml2-dev libssl-dev cmake git bash jq curl

RUN git clone https://github.com/taganaka/SpeedTest && cd SpeedTest && \
    cmake -DCMAKE_BUILD_TYPE=Release . && make install

RUN rm -rf SpeedTest /var/lib/apt/lists/*

COPY ./speedtest.sh .

RUN chmod 0755 ./speedtest.sh

CMD ["./speedtest.sh"]
