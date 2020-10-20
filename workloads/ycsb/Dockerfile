FROM alpine:latest

ADD https://github.com/brianfrankcooper/YCSB/releases/download/0.17.0/ycsb-0.17.0.tar.gz /

RUN apk add --no-cache openjdk8-jre \
 && tar xzvf /ycsb-0.17.0.tar.gz \
 && rm /ycsb-0.17.0.tar.gz

WORKDIR /ycsb-0.17.0
