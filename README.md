Purpose
-------
This solution provisions a single/multi node Weblogic 12.2.1.4 on OKE cluster and Jenkins CI/CD solution to build domain images. 

Following components are created as part of the stack:
* Container Cluster (OKE) with single node pool having two worker private nodes
* Shared file system and mount target
* Administrative Compute Instance for access ot OKE cluster
* Bastion Compute instance for access to the Administrative and OKE cluster in privat subnet
* Public Load balancer fronting the Weblogic Cluster
* Private Load balancer fronting Weblogic and Jenkins Console. 
* Internet gateway, Service and Nat Gateway


The solution will create only one stack at time and further modifications that are done will be done on the same stack. 
If multiple instances are desired then the user has to maintain terraform state in different locations or with different name. 
One terraform state file is generated per stack. So for multiple stacks ensure that a unique name is used for terraform state file. 
And this can be achieved by using the option -state="{unique dir or name of .tfstate file}" at the time of terraform apply.

**Network Topology for Weblogic on Container Cluster**
-------------
Creates following regional subnets under new VCN or existing VCN.
* Load balancer public subnet
* FSS private subnet 
* Container Cluster (OKE)  private subnet
* Admin private subnet
* Bastion public subnet


Organization
-------------
**inputs** - this directory consists of following:
* **env_vars_template** (for secret input variables - like user's api signing key details).
* **instance.tfvars.template** - for wls and OKE cluster instance specific config
* **db_systems.tfvars.template** - for OCI DB specific config
* **atp_db.tfvars.template** - for ATP DB specific config

**Note:** rename the xx.tfvars.template to corresponding xx.tfvars and provide environment specific values.

* **main.tf** - is where we call the modules in order as defined in ../modules.
* **outputs.tf** - result printed on the stdout at the completion of terraform provisioning.
* **provider.tf** - oci provider is defined.
* **edition.tf** -  Weblogic edition.
* **datasources.tf** - pre-fetch tenancy related information.
* **variables.tf** - defines the variables that are passed to modules as inputs for the Weblogic on OKE service.
* **wls-variables.tf** - defines the variables that are passed to modules as input for Weblogic.
* **db-variables.tf** - defines the variables that are passed to modules as input for ATP/OCI DB systems.
* **oke-variables.tf** - defines the variables that are passed to modules as input for Container cluster(OKE)
* **network-variables.tf** - defines the variables that are passed to modules as input for Network.
* **ingress-variables.tf** - defines the variables that are passed to modules as input for Ingress load balancer.
* **jenkins-variables.tf** - defines the variables that are passed to modules as input for Jenkins.
* **ingress-variables.tf** - defines the variables that are passed to modules as input.
* **mp-subscription-variables.tf** - defines the variables that are passed to modules as input for marketplace subscription.

Pre-requisites
--------------------
The terraform OCI provider supports API Key based authentication and Instance Principal based authentication.

The terraform modules supports only version v0.12+.

User has to create an OCI account in the his tenancy. Here are the authentication information required 
for invocation of Terraform scripts. 

**Tenancy OCID** - The global identifier for your account, always shown on the bottom of the web console.

**User OCID** - The identifier of the user account you will be using for Terraform

**Fingerprint** - The fingerprint of the public key added in the above user's API Keys section of the web console. 

**Private key path** - The path to the private key stored on your computer. The public key portion must be added to the user account above in the API Keys section of the web console. 


To invoke Terraform
--------------------
From solution dir (wls) execute:

### Initialize the terraform provider plugin
```bash
$ terraform init
```

### Init the environment with terraform environment vars
```bash
$ source inputs/env_vars
```

### Invoke apply passing all *.tfvars files as input
If you don't specify the -var-file then defaults in vars.tf will apply.

**WLS Non JRF:**
```bash
$ terraform apply -var-file=inputs/instance.tfvars 
```
**WLS JRF with OCI DB:**

```bash
$ terraform apply -var-file=inputs/instance.tfvars -var-file=inputs/oci_db.tfvars
```

**WLS JRF with ATP DB:**
```bash
$ terraform apply -var-file=inputs/instance.tfvars -var-file=inputs/atp_db.tfvars

```
**Creating Multiple instances from same solutions:**
```bash
$ terraform apply -var-file=inputs/instance.tfvars -state=<use unique dir or state file name for each stack>
```


### To destroy the infrastructure

**WLS Non JRF:**
```bash
$ terraform destroy -var-file=inputs/instance.tfvars 
```

**WLS JRF with OCI DB:**
```bash
$ terraform destroy -var-file=inputs/instance.tfvars -var-file=inputs/oci_db.tfvars
```

**WLS JRF with ATP DB:**
```bash
$ terraform destroy -var-file=inputs/instance.tfvars -var-file=inputs/atp_db.tfvars
```

To invoke Terraform using Resource Manager
--------------------

The artifacts are published to idoru by nightly builds. User will have to download the terraform scripts zip to use with
Resource Manager.

* Idoru Link: http://idoru.oraclecorp.com/#/services/WebLogicOciOke
* Artifact Name: wlsoke-resource-manager-ee-12.2.1.4.200114, wlsoke-resource-manager-suite-12.2.1.4.200114
* Working directory: ./


What it does
-------------

**Pre-requisites for Non JRF Weblogic 12c :** 
* User will provide compartment OCID to provision Weblogic 12c with all the networking. 
* User also has option to use pre existing VCN. Only mandatory requirement is that it should have internet gateway pre-configured along with service and NAT gateway.


* **Inputs to terraform:**
    *  User will provide the following mandatory parameter for provisioning:
        * Authentication information
            * Tenancy OCID 
            * User OCID
            * Path to private key 
            * FingerPrint
        * Compartment OCID
        * Network Compartment id
        * Region
        * SSH public key
        * Resource prefix
        * WLS parameters 
            * wls_admin_user
            * wls_admin_password_ocid
        * Networking details  (require if using existing network)
            * existing_vcn_id 
            * existing_lb_subnet_id
            * existing_bastion_subnet_id
            * existing_oke_workers_subnet_id 
            * existing_admin_subnet_id
            * existing_fss_subnet_id
            * existing_nat_gw_id - Either nat gateway or service gateway id is mandatory
            * existing_service_gw_id -Either nat gateway or service gateway id is mandatory
        * Load Balancer Parameter
            * lb_shape - public load balancer shape 
            * ingress_lb_shape - ingress load balancer shape

    ** NOTE:** User will need to ensure the subnet CIDRs are subset of the DB VCN's CIDR.
    
* **Provisioning flow** will be as follows:
    * **Create VCN (if not using existing)**
    * **Create Internet gateway, Service and NAT gateways (if not preconfigured), Route tables, and Security Lists**
    * **Create Subnets**
        * Creates subnets as per the topology described above
    * **Create Bastion andAdmin VM Instance**
        * Bastion instance to access admin vm and oke private worker nodes.
        * Admin instance for OKE cluster administration and life cycle operations.
    * **Create OKE Cluster with configured nodepool**
        * Container Cluster with two private nodes in single nodepool
    * **Create Load balancer**
            * Create public Load balancer for weblogic cluster
            * Create private Load balancer for weblogic and jenkins console

**Required Parameters to use OCI DB systems as infrastructure DB:**
* User will configure the DB subnet's seclist with a secrule to open up 1521 port for VCN CIDR.
* Also user should have created an internet gateway in the VCN.

* **Inputs to terraform:**
    * User will provide the following as param to terraform in addition to the mandatory parameters listed above:
        * OCI database Params:
            * ocidb_compartment_id
            * ocidb_dbsystem_id
            * ocidb_database_id
            * ocidb_pdb_service_name
            * oci_db_user
            * oci_db_password
        
        **NOTE:** User will need to ensure the subnet CIDRs are subset of the DB VCN's CIDR.

**Required Parameters to use ATP as infrastructure DB:**
    * User will provide the following as param to terraform in addition to the WLS parameters listed above:
        * ATP database Params:
            * atp_db_compartment_id
            * atp_db_password
            * atp_db_level
            * atp_db_id

Limitations
--------
* To use existing VCN, user needs to ensure that internet gateway and service/NAT gateway is preconfigured.
* It can only support WLS on OKE and OCI DB in same VCN.