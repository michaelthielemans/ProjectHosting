You can now join any number of the control-plane node running the following command on each as root:

  kubeadm join api-server:6443 --token lijweq.k10w05qneredea51 \
	--discovery-token-ca-cert-hash sha256:117a8b6ae7d3b01b3c4959e7d205cc8d924be37a8ce8142e4a2a550d5db5fdaf \
	--control-plane --certificate-key 41a89e6cd59e96106a60a37138e6295a39bb7cb9cb4e86388cbd5e116168625f

Please note that the certificate-key gives access to cluster sensitive data, keep it secret!
As a safeguard, uploaded-certs will be deleted in two hours; If necessary, you can use
"kubeadm init phase upload-certs --upload-certs" to reload certs afterward.

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join api-server:6443 --token t8rr62.8mzpoeavljz332ue \
	--discovery-token-ca-cert-hash sha256:117a8b6ae7d3b01b3c4959e7d205cc8d924be37a8ce8142e4a2a550d5db5fdaf
