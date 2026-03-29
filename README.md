# Multi-Service E-Commerce Deployment on AWS

## 📌 Project Overview
This project demonstrates the automated deployment of a microservices-based E-commerce application. The solution uses **Terraform** for Infrastructure as Code (IaC) and **Docker** for containerization, ensuring a consistent environment from development to production on **AWS**.

### Application Components:
* **Frontend**: React-based user interface.
* **User Service**: Handles authentication and profiles.
* **Product Service**: Manages the product catalog.
* **Order Service**: Processes customer orders.
* **Cart Service**: Manages temporary shopping carts.

---

## 🏗️ Architecture & Infrastructure
The infrastructure is provisioned on AWS using a single-node Docker host approach for high-speed deployment.

| Component | Technology | Detail |
| :--- | :--- | :--- |
| **Cloud Provider** | AWS | Region: us-east-1 |
| **Infrastructure** | Terraform | v1.x+ |
| **Compute** | EC2 Instance | Ubuntu 22.04 (t3.medium) |
| **Containerization**| Docker | Engine v24.x |
| **Networking** | Security Group | Ports 80, 3001-3004 |

### Port Mapping Table
| Service | Container Port | Host Port | Access |
| :--- | :--- | :--- | :--- |
| **Frontend** | 3000 | 80 | Public |
| **User** | 3001 | 3001 | Internal/Private |
| **Products** | 3002 | 3002 | Internal/Private |
| **Orders** | 3003 | 3003 | Internal/Private |
| **Cart** | 3004 | 3004 | Internal/Private |

---

## 🚀 Deployment Steps

### 1. Containerization (Manual)
Each service in the `/user`, `/products`, `/orders`, `/cart`, and `/frontend` directories contains a `Dockerfile`.
```bash
# Example Build & Push (Repeat for all 5 services)
docker build -t <your-dockerhub-username>/ecommerce-frontend ./frontend
docker push <your-dockerhub-username>/ecommerce-frontend
```


### 2. Infrastructure Provisioning (Terraform)
Initialize the Terraform directory:

#Bash
terraform init
Review the execution plan:

#Bash
terraform plan
Apply the configuration to provision AWS resources:

#Bash
terraform apply -auto-approve
3. Post-Deployment Verification
Once Terraform completes, it will output the Public IP of the EC2 instance.

Frontend URL: http://<EC2_PUBLIC_IP>

Health Check: Ensure all containers are running by SSHing into the instance and running docker ps.

###🛠️ Terraform Logic
The main.tf file utilizes a User Data script to automate the "Day 0" operations:

System Update: Updates APT packages.

Docker Installation: Installs and starts the Docker engine.

Automated Pull: Fetches the latest images from DockerHub.

Container Orchestration: Starts all 5 services with the correct port mappings and restart policies.

###📝 Evaluation Criteria Met
[x] VPC & Security Group: Configured for public web traffic and private inter-service communication.

[x] EC2 Provisioning: Automated via Terraform.

[x] Docker Deployment: Used user-data for zero-touch service startup.

[x] Public Accessibility: Frontend mapped to standard HTTP port 80.
docker build -t <your-dockerhub-username>/ecommerce-frontend ./frontend
docker push <your-dockerhub-username>/ecommerce-frontend
