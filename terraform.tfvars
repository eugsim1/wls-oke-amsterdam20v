#compartment_ocid   = "ocid1.compartment.oc1..aaaaaaaa375sfgxnc24b3rmxjju6ttxv264t6ukiyv42txxfxs3zj2difroa"
#region             = "eu-amsterdam-1"
#tenancy_ocid       = "ocid1.tenancy.oc1..aaaaaaaazvorzuwptfwqsu6xw4slonllvenoh3lbb3yikela4xntjoibd4ka"
kubernetes_version = "v1.17.9"

##  "v1.18.10"

non_wls_node_pool_count = 2

vcn_strategy = "Create New VCN"
lb_shape     = "100Mbps"


wls_node_pool_shape     = "VM.Standard2.1"
non_wls_node_pool_shape = "VM.Standard2.1"

##admin_availability_domain = "WtoZ:eu-amsterdam-1-AD-1"
##network_compartment_id    = "ocid1.compartment.oc1..aaaaaaaa375sfgxnc24b3rmxjju6ttxv264t6ukiyv42txxfxs3zj2difroa"
resource_prefix           = "wls"
ssh_public_key            = "wls-wdt-testkey-pub.txt"
wls_admin_user            = "weblogic"
wls_admin_password_ocid   = "ocid1.vaultsecret.oc1.eu-amsterdam-1.amaaaaaa4g77oeyahogz6ttg2bscgtin6nienmb44fbjwe2bd7ugrujj6jua"
##fss_availability_domain   = "WtoZ:eu-amsterdam-1-AD-1"


ocir_auth_token_ocid = "XXXXXX"
ocir_user            = "XXXXXX"

wls_domain_name = "okewls"
wls_node_pool_count = 2
###wls_configured_ms_count = 1
deploy_sample_app = false
###WElcome1412#