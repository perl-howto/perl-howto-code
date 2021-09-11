FROM ubuntu:focal
# https://hub.docker.com/_/ubuntu/
# https://github.com/docker-library/official-images

LABEL maintainer="Thomas Fahle <perlhowto.github.io@gmail.com>"
LABEL version="0.10"
LABEL description="Just Another Docker Ubuntu Focal Image running Dancer2 hello-world using build-in server"


# Upgrade already installed packages
# Install Dancer2
# Install File::Slurper
# Install Template-Toolkit
# Install SQLite3
# Install vim
# Autoremove unused packages
# Clean local repos
# Free disk space to decrease image size
ARG DEBIAN_FRONTEND=noninteractive
RUN set -ex; \
       apt-get update && \
       apt-get dist-upgrade -y && \
       apt-get -qq -y --no-install-recommends install \
       libdancer2-perl \
       libfile-slurper-perl \
       libtemplate-perl \
       sqlite3 libdbd-sqlite3-perl \
       vim \
       && apt-get -y autoremove && apt-get clean \
       ; \
    rm -rf /var/lib/apt/lists/* ; \
    rm -rf /tmp/*

WORKDIR /app

COPY ./hello-world.pl /app/

EXPOSE 3000/tcp

ENTRYPOINT ["perl", "/app/hello-world.pl"]


# Build image
# sudo DOCKER_BUILDKIT=1 docker build -t dancer-hello-world .

# Run container detached
# sudo docker run -p 3000:3000 -d --name dancer dancer-hello-world

# Show all containers
# sudo docker ps -a

# Inspect container logs
# sudo docker logs dancer
# >> Dancer2 v0.300000 server 1 listening on http://0.0.0.0:3000

# Open a browser or run curl
# curl 0.0.0.0:3000

# Login into the running container
# sudo docker exec -it dancer /bin/bash

# Override entrypoint for debugging purposes - runs a new container
# sudo docker run -p 3000:3000 --name dancer-x --entrypoint='' -it --rm dancer-hello-world /bin/bash

# Stop container
# sudo docker stop dancer

# Distribute
# sudo docker save dancer-hello-world -o myimage.tar
# sudo gzip myimage.tar
# Send myimage.tar.gz to customer
#
# gunzip myimage.tar.gz
# sudo docker load -i myimage.tar
# >> Loaded image: dancer-hello-world:latest
# sudo docker images

# Clean up
# Remove container
# sudo docker rm dancer
# Remove image
# sudo docker rmi dancer-hello-world
