#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install git jq bc make automake rsync htop curl build-essential \
	pkg-config libffi-dev libgmp-dev libssl-dev libtinfo-dev libsystemd-dev \
	zlib1g-dev make g++ wget libncursesw5 libtool autoconf -y
