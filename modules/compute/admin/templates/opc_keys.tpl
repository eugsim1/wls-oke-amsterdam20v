#!/bin/bash


echo "Creating ssh folder" >> /tmp/init.log

cp /home/opc/.ssh/authorized_keys /home/opc/.ssh/authorized_keys.bak
echo "${opc_ssh_pubKey}" >> /home/opc/.ssh/authorized_keys
chown -R opc /home/opc/.ssh/authorized_keys


echo "${opc_ssh_private_key}" >> /home/opc/.ssh/id_rsa
chown -R opc /home/opc/.ssh/id_rsa
chmod 400 /home/opc/.ssh/id_rsa

echo "Added keys to auth keys" >> /tmp/init.log