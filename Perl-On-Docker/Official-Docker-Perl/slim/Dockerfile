FROM perl:5.34.0-slim
# https://github.com/perl/docker-perl/blob/311f05366d91427d289740dd15fb9401dc4347ef/5.034.000-slim-buster/Dockerfile
# pulls debian:buster-slim
# https://github.com/debuerreotype/docker-debian-artifacts/blob/3714465332cd80e3d37ef7a611ad558424ecc03d/buster/slim/Dockerfile


LABEL maintainer="Thomas Fahle <perlhowto.github.io@gmail.com>"
LABEL version="0.10"
LABEL description="Just Another Docker perl:5.34.0 slim Image running Dancer2 hello-world using build-in server"


# apt-get
# Upgrade already installed packages
# Install build-essential (gcc, cc, make, ...)
# Install SQLite3 database and devel
#
# cpanm
# Install Dancer2
# Install File::Slurper
# Install Template-Toolkit
# Install DBD::SQLite
#
# apt-get
# Remove/Purge build-essential
# Autoremove unused packages
# Clean local repos
#
# Free disk space to decrease image size
ARG DEBIAN_FRONTEND=noninteractive
RUN set -ex; \
    apt-get update && \
      apt-get dist-upgrade -y && \
      apt-get -y -qq --no-install-recommends install \
        build-essential \
        libsqlite3-0 \
        sqlite3 \
        ; \
    /usr/local/bin/cpanm --notest \
      Dancer2 \
      DBD::SQLite \
      File::Slurper \
      Template \
      ; \
    apt-get -y purge build-essential && \
        apt-get -y autoremove && \
        apt-get clean ; \
    rm -rf /var/lib/apt/lists/* ; \
    rm -rf /tmp/* ; \
    rm -rf /root/.cpanm/

WORKDIR /app

COPY ./hello-world.pl /app/

EXPOSE 3000/tcp

ENTRYPOINT ["/usr/local/bin/perl", "/app/hello-world.pl"]

