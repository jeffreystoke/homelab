#
#
#
# Environment Variables Template
# DO NOT EDIT THIS FILE, copy to env.sh
# cp env.template.sh env.sh
#
#
#

# In this template, we made some assumption to simplify the understanding of the
# configuration, read it first, and you are good to go!
# 
# Network
# 
# - 172.16.0.0/24 (your local ip addresses)
# - 1.0.0.0/8 (your public ip addresses, assigned by ISP)
# - 10.0.0.0/16 (your kubernetes pod ip addresses)
# - 10.255.0.0/16 (your kubernetes service ip addresses)
# 
# Name prefix
# 
# - prefix HOMELAB (related to your physical gadgets)
# - prefix REMOTE (related to your public addresses)
# 
# - prefix KUBE (related to your kubernetes cluster)
# - prefix CTRL (related to your kubernetes controllers)
# - prefix WORKER (related to your kubernetes workers)
# 
# - prefix VER (related to version)


# 
# 
# HOMELAB section
# 
# 
# local physical network related
export HOMELAB_GW_IPV4="172.16.0.1"
export HOMELAB_DNS_SRV="172.16.0.1"
export HOMELAB_NET_PREFIX_LEN="24"

# local address and port for kube-apiserver
# used by kube-proxy, and kubelet
export HOMELAB_KUBE_PUB_ADDR="172.16.0.1"
export HOMELAB_KUBE_API_SERVER_PORT="6443"

# 
# 
# REMOTE section
# 
# 
# public address and port for kube-apiserver 
# if you want to enable remote access, you have to setup port-forward 
# on your router if you are using NAT
# if you don't need it, set them to be identical with 
# HOMELAB_KUBE_PUB_ADDR and HOMELAB_KUBE_API_SERVER_PORT
export REMOTE_KUBE_PUB_ADDR="1.1.1.1"
export REMOTE_KUBE_API_SERVER_PORT="6443"

# 
# 
# WORKER section
# 
# 
# WORKER_LIST MUST be identical with worker hostnames, 
# they will be used by some services (e.g. metrics-server) to reach kubelet
export WORKER_LIST=("my-kube-worker-1" "my-kube-worker-2" "my-kube-worker-3")
export WORKER_NET_IFACE_LIST=("ens160" "ens160" "ens160" "ens160")
export WORKER_INTERN_IP_LIST=("172.16.0.101" "172.16.0.102" "172.16.0.103")
export WORKER_EXTERN_IP_LIST=("1.2.2.1" "1.2.2.2" "1.2.2.3")
export WORKER_POD_CIDR_LIST=("10.0.1.0/24" "10.0.2.0/24" "10.0.3.0/24")
# ssh config for maintaince
export WORKER_SSH_PORT_LIST=("22" "22" "22")
export WORKER_SSH_ID_LIST=("~/.ssh/id_rsa" "~/.ssh/id_rsa" "~/.ssh/id_rsa")
export WORKER_SSH_USER_LIST=("user" "user" "user")
export WORKER_SSH_USER_PASS_LIST=("my_sudo_password" "my_sudo_password" "my_sudo_password")

# 
# 
# CTRL section
# 
# 
# CTRL_LIST is not restricted by controller hostnames
export CTRL_LIST=("my-kube-ctrl")
export CTRL_NET_IFACE_LIST=("ens160")
export CTRL_INTERN_IP_LIST=("10.100.100.100")
export CTRL_EXTERN_IP_LIST=("1.3.3.1")
# ssh config for maintaince
export CTRL_SSH_PORT_LIST=("22")
export CTRL_SSH_ID_LIST=("~/.ssh/id_rsa")
export CTRL_SSH_USER_LIST=("user")
export CTRL_SSH_USER_PASS_LIST=("my_sudo_password")

# 
# 
# KUBE section
# 
# 
export KUBE_CLUSTER_NAME="kubernetes-the-hard-way"
export KUBE_CONTEXT_NAME="default"
export KUBE_NODE_PORT_RANGE="30000-32767"
# pods cidr (cluster cidr in kubernetes) to include all worker pod ip address
export KUBE_PODS_CIDR="10.0.0.0/16"
# IP range to assign to kubernetes services
# MUST NOT overlap with any IP ranges assigned to nodes or pods
# 
# For example, when set to 10.254.0.0/16,
# the name `kubernetes` will be resolved to 10.254.0.1
# this range has nothing to do with pod address, physical address
# and is totally managed by kubernetes, used to represent 
# all kinds of service (svc) abstraction, for LoadBalancing
export KUBE_SVC_CIDR="10.255.0.0/16"
export KUBE_SVC_DNS="10.255.255.254"
export KUBE_SVC_KUBERNETES="10.255.0.1"

# Kubernetes etcd
export KUBE_ETCD_CLUSTER_NAME="etcd-cluster-kube"
export KUBE_ETCD_LISTEN_CLIENT_PORT="2379"
export KUBE_ETCD_LISTEN_PEER_PORT="2380"

# Kubernetes certificates (change them as you wish)
export KUBE_CERT_ORG_UNIT="Kubernetes The Hard Way"
export KUBE_CERT_COUNTRY="US"
export KUBE_CERT_LOCATION="Portland"
export KUBE_CERT_STATE="Oregon"

# 
# 
# VER(sion) section
# 
# 
export VER_KUBE="1.13.3"
export VER_ETCD="3.3.10"
export VER_CRICTL="1.13.0"
export VER_RUNC="1.0.0-rc6"
export VER_RUNSC=""
export VER_CONTAINERD="1.2.2"
export VER_CNI_SPEC="0.3.1"
export VER_CNI_PLUGINS="0.7.4"
