#!/bin/bash
echo "Initializing, Updating, and Installing Components"
apt-get update -y && apt install metasploit-framework -y &&  apt install nmap -y && \
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && service ssh start && msfupdate && sudo apt-get -y install openvas && sudo gvm-setup
