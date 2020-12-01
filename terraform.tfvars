#compartment_ocid   = "XXXXXXX"
#region             = "XXXXXXX"
#tenancy_ocid       = "XXXXXXX"
kubernetes_version = "v1.17.9"
##  "v1.18.10"

non_wls_node_pool_count = 2

vcn_strategy = "Create New VCN"
lb_shape     = "100Mbps"


wls_node_pool_shape     = "VM.Standard2.1"
non_wls_node_pool_shape = "VM.Standard2.1"

##admin_availability_domain = "XXXXXX"
##network_compartment_id    = "XXXXXX"
resource_prefix           = "wls"
ssh_public_key            = "wls-wdt-testkey-pub.txt"
wls_admin_user            = "weblogic"
wls_admin_password_ocid   = "XXXXXXX"
##fss_availability_domain   = "WtoZ:eu-amsterdam-1-AD-1"


ocir_auth_token_ocid = "XXXXXX"
ocir_user            = "XXXXXX"

wls_domain_name = "okewls"
wls_node_pool_count = 2
deploy_sample_app = false
 