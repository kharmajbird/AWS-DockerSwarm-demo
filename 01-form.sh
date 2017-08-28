#!/bin/bash


cd cloud-provisioning/terraform/aws

EXPORT TF_VAR_swarm_ami_id=$(\
    grep 'artifact,0,id' packer-ubuntu-docker.log \
    cut -d, -f6| cut -d: -f2)

EXPORT KEY_PATH=$HOME/.ssh/devops21.pem 
cp -av $KEY_PATH devops21.pem

terraform plan && \
terraform graph && \
terraform graph| dot -Tpng > graph.log


terraform apply \
    -target aws_instance.swarm-manager \
    -var swarm_init=true \
    -var swarm_managers=1 && \
\
ssh -i devops21.pem \
    ubuntu@$(terraform output swarm_manager_1_public_ip) \
    docker node ls
