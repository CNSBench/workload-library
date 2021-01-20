### 1. Build Image ###
FROM ubuntu:20.04 AS build

## update alpine
RUN apt-get update \
	&& apt-get upgrade -y

## install build tools
RUN apt-get install -y \
	g++ \
	git \
	make

## compression libraries + gflags
# bzip2 is a CLI tool; no library exists
# bzip2 is added here for completeness
RUN apt-get install -y \
	libgflags-dev \
	libsnappy-dev \
	zlib1g-dev \
	bzip2 \
	liblz4-dev \
	libzstd-dev

# build db_bench
WORKDIR /benchmark
RUN git clone --branch 6.13.fb --single-branch https://github.com/facebook/rocksdb.git
RUN cd rocksdb && \
	make db_bench DEBUG_LEVEL=0 && \
	cp db_bench ../db_bench

#### 2. Install Image ###
FROM ubuntu:20.04
WORKDIR /benchmark
COPY --from=build /benchmark/db_bench .

## install runtime compression libraries
# snappy is installed
# zlib is upgraded
# lz4 & zstd are already installed
# bzip2 is added here for completeness
RUN apt-get update && \
	apt-get install -y \
		libgflags2.2 \
		libsnappy1v5 \
		zlib1g \
		bzip2 \
		liblz4-1 \
		libzstd1 && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

