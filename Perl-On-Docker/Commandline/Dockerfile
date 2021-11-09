FROM perl:latest

LABEL maintainer="Thomas Fahle <perlhowto.github.io@gmail.com>"
LABEL version="0.10"
LABEL description="W3C::LinkChecker checklink Docker Image"


# apt-get
# Upgrade already installed packages (security)
# Install w3c-linkchecker (/usr/bin/checklink)
# Autoremove unused packages
# Clean local repos
#
# cpanm
# Install W3C::LinkChecker (/usr/local/bin/checklink)
# Install LWP::Protocol::https to enable linkckecking of HTTPS websites
#
# Free disk space to decrease image size
ARG DEBIAN_FRONTEND=noninteractive
RUN set -ex; \
       apt-get update && \
       apt-get dist-upgrade -y && \
       apt-get -y --no-install-recommends install \
       w3c-linkchecker && \
       apt-get -y autoremove && \
       apt-get clean ; \
       /usr/local/bin/cpanm  \
        W3C::LinkChecker \
        LWP::Protocol::https \
        ; \
    rm -rf /var/lib/apt/lists/* ; \
    rm -rf /tmp/* ; \
    rm -rf /root/.cpanm/

# Remember, in order to use CMD values as ENTRYPOINT arguments, ENTRYPOINT must be defined in exec form.
ENTRYPOINT ["/usr/local/bin/checklink"]
CMD ["--help"]


# sudo DOCKER_BUILDKIT=1 docker build -t w3c-checklink .

# sudo docker run --rm w3c-checklink --version
# sudo docker run --rm w3c-checklink --cookies tmp --broken  https://perl-howto.github.io

# Enable Signals (CRTL-C)
# https://docs.docker.com/engine/reference/run/#specify-an-init-process
# sudo docker run --init --rm w3c-checklink --cookies tmp --summary https://perl-howto.github.io

# Debug
# sudo docker run --rm -it --entrypoint='' w3c-checklink /bin/bash

# Use /usr/bin/checklink
# sudo docker run --init --rm --entrypoint='/usr/bin/checklink' w3c-checklink --version
