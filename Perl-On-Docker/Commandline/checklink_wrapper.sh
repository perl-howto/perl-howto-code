#!/bin/bash
# A wrapper script to run checklink (1p) from within a Docker image
sudo docker run --init --rm w3c-checklink "$@"
