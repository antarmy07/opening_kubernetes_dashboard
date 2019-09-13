 #!/usr/bin/env bash

create_kubernetes_dashboard () {

# To create a Kubernetes dashboard, run the following command:
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

# To make metrics and graphs available on your dashboard with Heapster, run the following command:
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml

#  To create a deployment and service, run the following command:
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml

# To create a cluster role binding for the dashboard, run the following command:

kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml

# To create a new service account with cluster admin privileges, run the following command:
cat > eks-admin-service-account.yaml << EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: eks-admin
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: eks-admin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: eks-admin
  namespace: kube-system
EOF

#  To bind eks-admin to the cluster role binding, run the following command:

kubectl apply -f eks-admin-service-account.yaml

}

# ------------------------------------

open_dashboards_proxy () {    
kubectl port-forward svc/kubernetes-dashboard -n kube-system 6443:443 &
sleep 5 
open -a "Google Chrome" https://127.0.0.1:6443 &
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
}


# ------------------------------------

create_kubernetes_dashboard 
open_dashboards_proxy
