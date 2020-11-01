FROM vout/megahit:latest

WORKDIR /root/megahit

RUN apt-get update && apt-get install -y --no-install-recommends time

RUN megahit --test && megahit --test --kmin-1pass
ENTRYPOINT ["megahit"]
