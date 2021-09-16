FROM perl:latest

LABEL maintainer="Thomas Fahle <perlhowto.github.io@gmail.com>"
LABEL version="0.10"
LABEL description="Perl-on-Docker perl:latest buildpacks-deps Image running Dancer2 Redis Example"


# apt-get
# Upgrade already installed packages
# Autoremove packages unused by other packages
# Clean local repos
#
# cpanm
# Install Dancer2
# Install Redis
#
# Free disk space to decrease image size

ARG DEBIAN_FRONTEND=noninteractive
RUN set -ex; \
    apt-get update && \
     apt-get dist-upgrade -y && \
     apt-get -y autoremove && \
     apt-get clean ; \
    /usr/local/bin/cpanm --notest \
      Dancer2 \
      Redis \
      ; \
    rm -rf /var/lib/apt/lists/* ; \
    rm -rf /tmp/* ; \
    rm -rf /root/.cpanm/

WORKDIR /app

COPY ./redis-counter.pl /app/

EXPOSE 3000/tcp

ENTRYPOINT ["/usr/local/bin/perl", "/app/redis-counter.pl"]


###############################################################################
# sudo DOCKER_BUILDKIT=1 docker build -t perl-redis-client-image .
# 
# sudo docker run -d --name perl-redis-client perl-redis-client-image  
# Debug
# sudo docker run -it --rm --entrypoint='' --name perl-redis-client perl-redis-client-image  /bin/bash
###############################################################################
