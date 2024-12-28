# K8S-APEX

This project aims to deploy **APEX applications** on a **Kind Kubernetes cluster**.  

In this first phase, it is assumed that you already have an **Oracle Database** running.

## ✨ Deployment Steps

### 1. Clone the Repository  
Clone the repository to your local machine:  
```bash
git clone https://github.com/gitdavidgarcia/K8S-APEX/
```

---

### 2. Build the ORDS Docker Image  
Navigate to the `ords` directory and build the Docker image: 
It is important to download the Apex image folder into this directory because it is necessary for the Docker image
```bash
cd K8S-APEX/ords
docker build -t ords:prueba .
```

---

### 3. Upload the Image to the Kind Cluster  
Load the built Docker image into the Kind cluster:  
```bash
kind load docker-image ords:prueba
```

---

### 4. Apply the Kubernetes Manifest  
Deploy the application by applying the Kubernetes manifest:  
```bash
kubectl apply -f ords.yml
```

---

### 5. Access the Application Externally (Optional)  
To access the application externally, forward a port. Replace `xxxxxxx` with the name of the running pod:  
```bash
kubectl port-forward --address 0.0.0.0 xxxxxxx 80:8080
```

💡 **Tip:** You can get the pod name using:  
```bash
kubectl get pods
```
---

## 📊 Notes
- Ensure your Oracle Database is running and accessible by the ORDS application.  
- Verify that the Kubernetes manifest (`ords.yml`) is correctly configured for your environment.  
---

## 🛠️ Useful Commands  

### Check Deployment Status  
```bash
kubectl get deployments
kubectl get services
kubectl exec --stdin --tty ordscontainer-6ccdd4f854-7gg6x -- /bin/bash
```

### List Running Pods  
```bash
kubectl get pods
```
