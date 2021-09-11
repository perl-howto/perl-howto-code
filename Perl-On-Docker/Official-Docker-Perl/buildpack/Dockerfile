FROM perl:5.34.0
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


LABEL maintainer="Thomas Fahle <perlhowto.github.io@gmail.com>"
LABEL version="0.10"
LABEL description="Just Another Docker perl:5.34.0 buildpacks-deps Image running Dancer2 hello-world using build-in server"


# apt-get
# Upgrade already installed packages
# Install SQLite3 databas
# Autoremove unused packages
# Clean local repos
#
# cpanm
# Install Dancer2
# Install File::Slurper
# Install Template-Toolkit
# Install DBD::SQLite
#
# Free disk space to decrease image size
ARG DEBIAN_FRONTEND=noninteractive
RUN set -ex; \
       apt-get update && \
       apt-get dist-upgrade -y && \
       apt-get -y -qq --no-install-recommends install sqlite3 && \
       apt-get -y autoremove && \
       apt-get clean ; \
       /usr/local/bin/cpanm --notest \
        Dancer2 \
        Template \
        File::Slurper \
        DBD::SQLite \
        ; \
    rm -rf /var/lib/apt/lists/* ; \
    rm -rf /tmp/* ; \
    rm -rf /root/.cpanm/

WORKDIR /app

COPY ./hello-world.pl /app/

EXPOSE 3000/tcp

ENTRYPOINT ["/usr/local/bin/perl", "/app/hello-world.pl"]

