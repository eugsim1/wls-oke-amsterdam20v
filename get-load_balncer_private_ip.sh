export LB_PRIV=`kubectl get services -n ingress-nginx | grep wls-internal | awk  '{print $4}'`
echo $LB_PRIV