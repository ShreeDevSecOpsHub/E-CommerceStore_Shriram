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
