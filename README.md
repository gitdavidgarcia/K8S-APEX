# K8S-APEX

This project aims to deploy **APEX applications** in HA on a **Kind Kubernetes cluster**.  

## ✨ Deployment Steps

### 1. Install Kind over Ubuntu 24 and create a kubernetes cluster
```bash
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.26.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

kind create cluster
```

### 2- Deploy Oracle Database with Dataguard for HA
Install cert-manager and Oracle DB Operator. For more information please check the official documentation 
```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.4/cert-manager.yaml \
kubectl apply -f database/oracle-database-operator.yaml
```
The only difference between the official documentation and this files is the storage option. I have choosen the standard tier upon oci-bv
```bash

kubectl apply -f database/singleinstancedatabase_create.yaml
kubectl apply -f database/singleinstancedatabase_standby.yaml
kubectl apply -f database/dataguardbroker.yaml
```
### 3. Build the ORDS Docker Image  
Navigate to the `ords` directory and build the Docker image: 
It is important to download the Apex image folder into this directory because it is necessary for the Docker image
```bash
cd K8S-APEX/ords
docker build -t ords:prueba .
```

---

### 4. Upload the Image to the Kind Cluster  
Load the built Docker image into the Kind cluster:  
```bash
kind load docker-image ords:prueba
```

---

### 5. Apply the Kubernetes Manifest  
Deploy the application by applying the Kubernetes manifest:  
```bash
kubectl apply -f ords.yml
```
### 6. Load Balancer and Autoescaling

In order to achieve HA with ORDS, it is important to deploy a load balancer in front of ORDS pods. Moreover, we can have horizontal scaling for saving resources
```bash
kubectl apply -f metallb/metal.yaml
kubectl apply -f hpa/hpa.yml
```


