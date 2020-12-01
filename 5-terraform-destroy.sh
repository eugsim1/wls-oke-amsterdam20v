#terraform destroy -auto-approve -var-file="secret.tfvars"  -var-file=instance_count.tfvars  -var-file="terraform.tfvars"
kubectl delete service --all -n ingress-nginx
terraform destroy   -auto-approve    -var-file="terraform.tfvars"  
