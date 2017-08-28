#!/bin/bash

. ../env
cd cloud-provisioning/terraform/aws

packer build -machine-readable \
    packer-ubuntu-docker.json \
    | tee packer-ubuntu-docker.log
