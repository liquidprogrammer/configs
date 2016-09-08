#!/bin/bash

########################
####### NODEJS #########
########################

NODEJS_VERSION=4

curl -sL https://deb.nodesource.com/setup_$NODEJS_VERSION.x | sudo -E bash -
sudo apt-get install -y nodejs



########################
######### NPM ##########
########################

NPM_G_DIR=~/.npm-global

# new directory for global installations
mkdir $NPM_G_DIR

# configure npm to use new directory path
npm config set prefix $NPM_G_DIR

# export .bin to PATH
BASHRC=~/.bashrc
echo "" >> $BASHRC
echo "" >> $BASHRC
echo "# NPM global binaries" >> $BASHRC
echo "export PATH=\"$NPM_G_DIR/bin:\$PATH\"" >> $BASHRC
