Content-Type: multipart/mixed; boundary=MIMEBOUNDARY
MIME-Version: 1.0

--MIMEBOUNDARY
Content-Transfer-Encoding: 7bit
Content-Type: text/cloud-config
Mime-Version: 1.0

#cloud-config

write_files:
- path: /etc/.firstboot_disable_reboot
  owner: root:root
  permissions: '0644'
  encoding: b64
  content: |
    dGhpcyBjb250ZW50IHBsYWNlZCBieSBjbG91ZC1pbml0Cg==

- path: /root/docker_login.sh
  owner: root:root
  permissions: '0755'
  encoding: b64
  content: |
      IyEvYmluL2Jhc2gKc2V0IC1lCmRvY2tlcl9sb2dpbiAoKSB7CiAgICBvY2lyX3VybD0kMQogICAgZWNobyAiTG9nZ2luZyBpbnRvICRvY2lyX3VybCIKICAgIGVjaG8gJG9jaXJfdXJsIHwgZG9ja2VyLWNyZWRlbnRpYWwtb2NpciBnZXQgfCBqcSAtciAuU2VjcmV0IHwgZG9ja2VyIGxvZ2luIC11IEJFQVJFUl9UT0tFTiAtLXBhc3N3b3JkLXN0ZGluICRvY2lyX3VybCB8fCB7IGVjaG8gY3JlZGVudGlhbCBoZWxwZXIgZmFpbGVkIHRvIGdldCB0b2tlbiA7IGV4aXQgMTsgfQp9Cmluc3RhbmNlTWV0YWRhdGE9JChjdXJsIC1MIC1IICdBdXRob3JpemF0aW9uOiBCZWFyZXIgT3JhY2xlJyBodHRwOi8vMTY5LjI1NC4xNjkuMjU0L29wYy92Mi9pbnN0YW5jZS9yZWdpb25JbmZvKQpyZWFsbT0kKGVjaG8gJGluc3RhbmNlTWV0YWRhdGEgfCBqcSAtciAnLnJlYWxtS2V5JykKZG9tYWluPSQoZWNobyAkaW5zdGFuY2VNZXRhZGF0YSB8IGpxIC1yICcucmVhbG1Eb21haW5Db21wb25lbnQnKQpyZWdpb25OYW1lPSQoZWNobyAkaW5zdGFuY2VNZXRhZGF0YSB8IGpxIC1yICcucmVnaW9uSWRlbnRpZmllcicpCnJlZ2lvbkNvZGU9JChlY2hvICRpbnN0YW5jZU1ldGFkYXRhIHwganEgLXIgJy5yZWdpb25LZXknIHwgdHIgJ1s6dXBwZXI6XScgJ1s6bG93ZXI6XScpCmlmIFsgJHJlYWxtID0gIm9jMSIgXTsgdGhlbgogICAgIyB3ZSBuZWVkIHRvIGxvZyBpbnRvIHRoZSBhaXJwb3J0IGNvZGUgYW5kIHRoZSBsb25nIG5hbWUgCiAgICAjIGZvciBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eSByZWFzb25zCiAgICBkb2NrZXJfbG9naW4gIiRyZWdpb25OYW1lLm9jaXIuaW8iCiAgICBkb2NrZXJfbG9naW4gIiRyZWdpb25Db2RlLm9jaXIuaW8iCmVsc2UKICAgIGRvY2tlcl9sb2dpbiAib2Npci4kcmVnaW9uTmFtZS5vY2kuJGRvbWFpbiIKZmkKZWNobyBGaW5pc2hlZCBEb2NrZXIgQ3JlZGVudGlhbCBIZWxwZXIgVG9rZW4gR2V0IFByb3Zpc2lvbmluZw==

- path: /var/run/docker-credential-helper-init.sh
  owner: root:root
  permissions: '0755'
  encoding: b64
  content: |
      IyEvYmluL2Jhc2ggLXhlCgpmdW5jdGlvbiBkaWUgeyBlY2hvICIke0B9IiAxPiYyIDsgZXhpdCAyOyB9CgpzZXQgLW8gcGlwZWZhaWwKCndoaWxlIFsgLWYgL3Jvb3QvZmlyc3Rib290LnNoIF0gOyBkbwogICAgZWNobyAiV2FpdGluZyBvbiBmaXJzdGJvb3QgdG8gY29tcGxldGUiCiAgICBzbGVlcCAxCmRvbmUKCiMgYW5kIGNoZWNrIHRoYXQgaXQgYXQgbGVhc3QgbGVmdCB0aGUgeXVtIHJlcG9zIGluIGEgZ29vZCBzdGF0ZQppZiBbIC16ICIkKHl1bSBsaXN0IC0tcXVpZXQgYW5zaWJsZSAyPi9kZXYvbnVsbCkiIF0gOyB0aGVuCiAgICBkaWUgImZpcnN0Ym9vdCBmYWlsZWQgdG8gcHJvcGVybHkgY29uZmlndXJlIHl1bSIKZmkKCnl1bSBpbnN0YWxsIC15IGphdmEtMS44LjAtb3Blbmpkawp5dW0gaW5zdGFsbCAteSBkb2NrZXItY3JlZGVudGlhbC1vY2lyCgovcm9vdC9kb2NrZXJfbG9naW4uc2ggfHwgeyBlY2hvIGRvY2tlciBsb2dpbiBmYWlsZWQgOyBleGl0IDE7IH0KbWtkaXIgLXAgL3Zhci9saWIva3ViZWxldApsbiAtcyAvcm9vdC8uZG9ja2VyL2NvbmZpZy5qc29uIC92YXIvbGliL2t1YmVsZXQvY29uZmlnLmpzb24=

- owner: root:root
  path: /etc/cron.d/docker-cred-helper
  content: |
    */20 * * * * root /root/docker_login.sh
    @reboot /root/docker_login.sh

output: {all: '| tee -a /var/log/cloud-init-output.log'}

logcfg: |
  [formatters]
  format=%(levelname)s %(asctime)s: %(message)s
--MIMEBOUNDARY
Content-Transfer-Encoding: 7bit
Content-Type: text/x-shellscript
Mime-Version: 1.0

#!/bin/bash
set -e
set -o pipefail

### insert customer pre oke-init.sh hook

echo "Disabling Swap Volumes"
swapon --summary
swapoff --all
sed -i.old '/swap/ s/^\(.*\)$/# \1/g' /etc/fstab
swapon --summary
cat /etc/fstab
echo "Swap Volumes Disabled"
### start OKE Provisioning
echo Starting OKE Provisioning
curl --fail -L0 -H "Authorization: Bearer Oracle" http://169.254.169.254/opc/v2/instance/metadata/oke_init_script | base64 --decode >/var/run/oke-init.sh
# workaround for IO images.
# https://jira-sd.mc1.oracleiaas.com/browse/CIO-311?focusedCommentId=9549417&page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel#comment-9549417
sed -i "/tar -xzvf - -C \/var\/run\/tkw/a\sed -i \"/name: https:\\\/\\\/objectstorage/a\ \\\ \\\ \\\ \\\ \\\ \\\ disablerepo: '*epel*'\" /var/run/tkw/roles/tkm-minion/tasks/main.yml" /var/run/oke-init.sh
until bash -x /var/run/oke-init.sh
do
    echo "oke-init failed... Trying again in 30s..."
    sleep 30
done
echo Finished OKE Provisioning

systemctl restart kubelet

### insert customer post oke-init.sh hook

# Import the FMW Image here. This image will be part of the nodepool instance and kept under /u01/zips
# Get the weblogic_repo for json file written during image creation.
weblogic_repo=`jq -r '.weblogic_repo' /u01/.docker_images.json`
find /u01/zips/*.gz -type f -print0 | xargs -r0 cat | docker import - ${weblogic_image_tag}/$weblogic_repo

--MIMEBOUNDARY--