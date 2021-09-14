# Stage 1: Build TA-LIB
FROM perl:5.34.0 as ta-lib
# https://github.com/perl/docker-perl/blob/311f05366d91427d289740dd15fb9401dc4347ef/5.034.000-main-buster/Dockerfile
# https://hub.docker.com/_/buildpack-deps/
# pulls buildpack-deps:buster
# https://github.com/docker-library/buildpack-deps/tree/65d69325ad741cea6dee20781c1faaab2e003d87/debian/buster
# pulls buildpack-deps:buster-scm
# https://github.com/docker-library/buildpack-deps/tree/65d69325ad741cea6dee20781c1faaab2e003d87/debian/buster/scm
# pulls buildpack-deps:buster-curl
# https://github.com/docker-library/buildpack-deps/tree/65d69325ad741cea6dee20781c1faaab2e003d87/debian/buster/curl
# pulls debian:buster
# https://hub.docker.com/_/debian/
# Debian Buster aka Debian 10


RUN set -ex; \
       wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && \
       tar -xvzf ta-lib-0.4.0-src.tar.gz && \
       cd ta-lib/ && \
       ./configure --prefix=/usr/local && \
       make && \
       make install; \
       cd .. ; \
       rm -rf ta-lib ta-lib-0.4.0-src.tar.gz ;

# Stage 2: Install Finance::TA 
FROM perl:5.34.0

LABEL maintainer="Thomas Fahle <perlhowto.github.io@gmail.com>"
LABEL version="0.10"
LABEL description="Perl on Docker - Finance::TA/ta-lib Container - based on perl:5.34.0 buildpacks-deps"

# Copy compiled (and cached) ta-lib from stage 1 into stage 2
COPY --from=ta-lib /usr/local/lib/libta_lib.* /usr/local/lib/
COPY --from=ta-lib /usr/local/bin/ta-lib-config /usr/local/bin/ta-lib-config
COPY --from=ta-lib /usr/local/include/ta-lib/ /usr/local/include/ta-lib/


# Upgrade already installed packages in noninteractive mode
# Install SQLite3
# Install tree
# Install vim
# Autoremove unused packages
# Clean local repos
#
# cpanm
# Install DBD::SQLite
# Install Finance::TA
# Install Text::CSV Text::CSV_XS Text::CSV_PP Text::CSV::Slurp
#
# Free disk space to decrease image size

ARG DEBIAN_FRONTEND=noninteractive
# Set TALIB_CFLAGS because 
# ta-lib-config --cflags returns incorrect data 
ARG TALIB_CFLAGS='-I/usr/local/include/ta-lib -DHAVE_CONFIG_H'
RUN set -ex; \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get -y -qq --no-install-recommends install sqlite3 tree vim && \
    apt-get -y autoremove && \
    apt-get clean \
    ; \
    /usr/local/bin/cpanm \
     DBD::SQLite \
     Finance::TA \
     Text::CSV Text::CSV_XS Text::CSV_PP Text::CSV::Slurp \
    ; \
    rm -rf /var/lib/apt/lists/* ; \
    rm -rf /tmp/* ; \
    rm -rf /root/.cpanm/

WORKDIR /app

# Copy simple demo program into container to check Finance::TA
COPY ./finance-ta-sma.pl /app/finance-ta-sma.pl

CMD ["/bin/bash"]

###############################################################################
# sudo DOCKER_BUILDKIT=1 docker build -t ta-lib-image .
#
# sudo docker run -it --rm --name ta-lib ta-lib-image
###############################################################################

