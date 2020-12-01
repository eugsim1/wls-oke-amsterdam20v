# Copyright 2020, Oracle Corporation and/or affiliates.  All rights reserved.

resource "oci_core_instance" "bastion" {
    lifecycle {
        ignore_changes = [ "freeform_tags" , "defined_tags",  ]
    }
	
  //assumption: it is the same ad as wls
  availability_domain = var.oci_bastion.availability_domain

  compartment_id = var.oci_identity.compartment_id
  display_name     = "${var.oci_bastion.label_prefix}-bastion"
  hostname_label   = "${var.oci_bastion.label_prefix}-bastion"

  shape          = var.oci_bastion.instance_shape

  create_vnic_details {
    subnet_id              = var.oci_bastion.subnet_id
    skip_source_dest_check = true
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = var.oci_identity.ssh_public_key
    user_data           = data.template_cloudinit_config.bastion-config.rendered
  }

  source_details {
    source_type = "image"
    source_id   = var.oci_bastion.instance_image_id
  }

  timeouts {
    create = "10m"
  }
}



resource "null_resource" "bastion_info_transfer" {
depends_on = [ oci_core_instance.bastion ]
/*
  triggers = {
    instance_id = var.oci_admin.admin_id
  }
*/
  connection {
    host = oci_core_instance.bastion.public_ip
    private_key = var.oci_identity.opc_ssh_private_key
    timeout = "5m"
    type = "ssh"
    user = "opc"


  }

  provisioner "remote-exec" {
    inline = [
	  "cd /home/opc",
	  "wget https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh",
	  "chmod u+x install.sh",
	  "./install.sh --accept-all-defaults",
      "mkdir -p $HOME/.kube",
      
      #Create cluster info
      "sudo su -c 'yum install -y nginx'",      
    ]
  }

 
  provisioner "file" {
    source     = "${path.module}/userdata/get-load_balncer_private_ip.sh"
    destination = "/tmp/get-load_balncer_private_ip.sh"
	}
  provisioner "remote-exec" {
    inline = [ "sudo su -c 'cp /tmp/get-load_balncer_private_ip.sh /home/opc/get-load_balncer_private_ip.sh'",
	           "sudo su -c 'chmod ugo+x /home/opc/get-load_balncer_private_ip.sh'",
			   "sudo su -c 'source /home/opc/get-load_balncer_private_ip.sh &&  sudo sed s/INTERNAL_IP/$LB_PRIV/g -i /etc/nginx/nginx.conf'",
               "sudo su -c 'systemctl start nginx'",
               "sudo su -c 'systemctl enable nginx'"	,
            ]			   
  }
 
  
}