#
#
#
# Environment Variables Template
# DO NOT EDIT THIS FILE, copy to env.sh
# cp env.template.sh env.sh
#
#
#

# local physical network related
export HOMELAB_GW="172.16.0.1"
export HOMELAB_NET_PREFIX_LEN="24"
export HOMELAB_DNS_SRV="172.16.0.1"

export KUBE_PUB_ADDR="10.0.0.10"
export KUBE_API_SERVER_PORT="6443"

# address and port for remote access ()
export REMOTE_KUBE_PUB_ADDR="1.1.1.1"
export REMOTE_KUBE_API_SERVER_PORT="6443"
# cluster cidr to include all worker pod cluster cidr
export KUBE_CLUSTER_CIDR="10.100.0.0/16"

# IP range to assign service cluster IPs
# MUST NOT overlap with any IP ranges assigned to nodes for pods
export KUBE_SERVICE_IP_RANGE="10.32.0.0/24"
# cluster dns server address in coredns.yaml
# dns server is a service, so in range 10.
export CLUSTER_DNS_SERVER="10.10.0.254"

export KUBE_SERVICE_CLUSTER_GW_ADDR="10.0.0.1"

export KUBE_NODE_PORT_RANGE="30000-32767"

export CLUSTER_NAME="kubernetes-the-hard-way"
export CONTEXT_NAME="default"

# CTRL_LIST is not restricted by controller hostnames
export CTRL_LIST=("my-kube-ctrl")
export CTRL_NET_IFACE_LIST=("ens160")
export CTRL_INTERN_IP_LIST=("10.0.0.10")
export CTRL_EXTERN_IP_LIST=("10.0.0.10")
export CTRL_SSH_PORT_LIST=("22")
export CTRL_SSH_ID_LIST=("~/.ssh/id_rsa")
export CTRL_SSH_USER_LIST=("user")
# password for `sudo` in deployment
export CTRL_SSH_USER_PASS_LIST=("my_password")

# items in WORKER_LIST MUST be identical with worker hostnames
export WORKER_LIST=("my-kube-worker-1" "my-kube-worker-2" "my-kube-worker-3")
export WORKER_NET_IFACE_LIST=("ens160" "ens160" "ens160" "ens160")
export WORKER_INTERN_IP_LIST=("10.0.0.1" "10.0.0.2" "10.0.0.3")
export WORKER_EXTERN_IP_LIST=("10.0.0.1" "10.0.0.2" "10.0.0.3")
export WORKER_POD_CIDR_LIST=("10.100.0.0/24" "10.100.0.0/24" "10.100.0.0/24")
export WORKER_SSH_PORT_LIST=("22" "22" "22")
export WORKER_SSH_ID_LIST=("~/.ssh/id_rsa" "~/.ssh/id_rsa" "~/.ssh/id_rsa")
export WORKER_SSH_USER_LIST=("user" "user" "user")
# password for `sudo` in deployment
export WORKER_SSH_USER_PASS_LIST=("my_password" "my_password" "my_password")

export KUBE_ETCD_CLUSTER_NAME="etcd-cluster-kube"
export KUBE_ETCD_LISTEN_CLIENT_PORT="2379"
export KUBE_ETCD_LISTEN_PEER_PORT="2380"

export CERT_ORG_UNIT="Kubernetes The Hard Way"
export CERT_COUNTRY="US"
export CERT_LOCATION="Portland"
export CERT_STATE="Oregon"

# 
# 
# DO NOT Edit Variables Below, Unless You Know What You Are Doing
# 
# 

export COMP_KUBE_SERVICE_ACCOUNT="kube-service-account"
export COMP_KUBE_API_SERVER="kubernetes"
export COMP_KUBE_SCHEDULER="kube-scheduler"
export COMP_KUBE_CTRL_MGR="kube-controller-manager"
export COMP_KUBE_PROXY="kube-proxy"

export VER_KUBE="1.12.0"
export VER_ETCD="3.2.24"
export VER_RUNC="1.0.0-rc5"
export VER_RUNSC=""
export VER_CONTAINERD="1.2.0-rc.0"
export VER_CNI="0.3.1"
export VER_CNI_PLUGINS="0.6.0"

export GEN_DIR="generated"
export DOWNLOAD_DIR="download"

export WORKER_ADDR_LIST=""
export CTRL_ADDR_LIST""
export ETCD_INITIAL_CLUSTERS=""
export ETCD_SERVERS=""
export IP_ROUTE_CMD=""

for i in ${!WORKER_LIST[@]}
do
INTERN_IP=${WORKER_INTERN_IP_LIST[${i}]}
EXTERN_IP=${WORKER_EXTERN_IP_LIST[${i}]}
POD_CIDR=${WORKER_POD_CIDR_LIST[$i]}

export WORKER_ADDR_LIST="${INTERN_IP},${EXTERN_IP},${WORKER_ADDR_LIST}"
export IP_ROUTE_CMD="ip route add ${POD_CIDR} via ${INTERN_IP}\n${IP_ROUTE_CMD}"
done

for i in ${!CTRL_INTERN_IP_LIST[@]}
do
INTERN_IP=${CTRL_INTERN_IP_LIST[${i}]}
EXTERN_IP=${CTRL_EXTERN_IP_LIST[${i}]}
export CTRL_ADDR_LIST="${INTERN_IP},${EXTERN_IP},${CTRL_ADDR_LIST}"
done

for i in ${!CTRL_LIST[@]}
do
CONTROLLER=${CTRL_LIST[${i}]}
INTERN_IP=${CTRL_INTERN_IP_LIST[${i}]}
URL="https://${INTERN_IP}:${KUBE_ETCD_LISTEN_PEER_PORT}"
export ETCD_INITIAL_CLUSTERS="etcd-${CONTROLLER}=${URL},${ETCD_INITIAL_CLUSTERS}"
export ETCD_SERVERS="https://${INTERN_IP}:${KUBE_ETCD_LISTEN_CLIENT_PORT},${ETCD_SERVERS}"
done