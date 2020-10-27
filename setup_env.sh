#!/bin/bash

#
# install required tools to use terraform, aws and ansible
#

# install pip3 and setuptools
sudo apt install -y python3-pip python3-setuptools

#install terraform
wget https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip
unzip terraform_*.zip
sudo mv terraform /usr/local/bin
rm -f terraform_*.zip

# install aws cli
pip3 install awscli --user

# install ansible
pip3 install ansible --user
