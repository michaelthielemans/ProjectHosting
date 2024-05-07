# Install Cilium into the k8s cluster
Step 1 : install cilium cli
Step 2 : define which cilium features needs to installed
Step 3 : install cilium with cilium cli
step 4 : verify cilium

[github cilium info page](https://github.com/cilium/cilium-cli)

## 1. Install cilium CLI
```
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
GOOS=$(go env GOOS)
GOARCH=$(go env GOARCH)
curl -L --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-${GOOS}-${GOARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-${GOOS}-${GOARCH}.tar.gz.sha256sum
sudo tar -C /usr/local/bin -xzvf cilium-${GOOS}-${GOARCH}.tar.gz
rm cilium-${GOOS}-${GOARCH}.tar.gz{,.sha256sum}
```
## 2. 
## 3. Install cilium
```
cilium install
🔮 Auto-detected Kubernetes kind: minikube
✨ Running "minikube" validation checks
✅ Detected minikube version "1.5.2"
ℹ️  Cilium version not set, using default version "v1.9.1"
🔮 Auto-detected cluster name: minikube
🔑 Found existing CA in secret cilium-ca
🔑 Generating certificates for Hubble...
🚀 Creating service accounts...
🚀 Creating cluster roles...
🚀 Creating ConfigMap...
🚀 Creating agent DaemonSet...
🚀 Creating operator Deployment...
```
