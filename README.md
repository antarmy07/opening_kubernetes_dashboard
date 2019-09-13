# Install and Open Kubernetes Dashboard


This script will install all the dependecies for the Kubernetes dashboard:

1. Kubernetes dashboard
2. Heapster (data & metrics)
3. Influxdb (database)
3. Deployment services - pods
4. Role & cluster rolebinding for the service accounts
5. Cluster admin service account to access the dashboard with the token.

It will automatically forward port to 6443 and start the proxy, opens Google chrome for the dashboard and prints cluster admin's token that can be used to access the Kubernetes dashboard.

**Reference**

https://aws.amazon.com/premiumsupport/knowledge-center/eks-cluster-kubernetes-dashboard/

**NOTE**

For this script to work all dependencies tools should be installed and configured properly. 

Such as Kubctl, awscli (for AWS EKS), Kubernetes clusters, Google Chrome and etc. 
