FROM amazonlinux:2017.03

ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/
ENV GOPATH=/go
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin:~/go/bin
ENV LD_LIBRARY_PATH=/usr/local/lib/

# Libsodium and Go versions to install
ARG LIBSODIUM_VERSION="libsodium-1.0.17"
RUN yum update -y && \
    yum install -y zip gcc tar git wget

RUN wget --no-verbose -O go.tar.gz "https://dl.google.com/go/$(curl 'https://golang.org/VERSION?m=text').linux-amd64.tar.gz" && \
    tar -xzf go.tar.gz && \
    mv go /usr/local && \
    go version

RUN mkdir -p /tmpbuild/libsodium && \
    cd /tmpbuild/libsodium && \
    curl -L https://download.libsodium.org/libsodium/releases/$LIBSODIUM_VERSION.tar.gz -o $LIBSODIUM_VERSION.tar.gz && \
    tar xfvz $LIBSODIUM_VERSION.tar.gz && \
    cd /tmpbuild/libsodium/$LIBSODIUM_VERSION/ && \
    ./configure && \
    make && make check && \
    make install && \
    mv src/libsodium /usr/local/ && \
    rm -Rf /tmpbuild/