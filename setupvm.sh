apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet=1.15.4-00 kubeadm=1.15.4-00 kubectl=1.15.4-00 docker.io

if [$1 = $'master']
    kubeadm init
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
fi

kubeadm join --token 702ff6.bc7aacff7aacab17 174.138.15.158:6443 --discovery-token-ca-cert-hash sha256:68bc22d2c631800fd358a6d7e3998e598deb2980ee613b3c2f1da8978960c8ab
