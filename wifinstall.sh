#!/bin/bash
sudo apt-get update
sudo apt-get install -y build-essential dkms git
git clone https://github.com/fastoe/RTL8811CU.git
cd RTL8811CU
make
sudo make install

