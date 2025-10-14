<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/b3f9c959-9fb1-4e59-9c06-5929d58727d4" />


<img width="2560" height="1426" alt="3" src="https://github.com/user-attachments/assets/eea6be2b-7621-4b81-a25e-4436b933f176" />

# Brain Tasks React App Deployment on AWS

This project demonstrates how to deploy a **React application** into production using **AWS services**. The application is containerized with Docker,
stored in AWS ECR, deployed to **Kubernetes (EKS)**, and automated using **CodePipeline** and **CodeBuild**. Monitoring and logging are configured via **CloudWatch**.


## Project Overview

**Goal:** Turn a React app into a container image, push it to AWS ECR, deploy on an EKS cluster, and automate updates via a CI/CD pipeline.

**Workflow Summary:**
1. Developer pushes code to GitHub
2. CodePipeline detects changes
3. CodeBuild builds Docker image, pushes to ECR
4. Kubernetes deployment updated automatically
5. Application is served via LoadBalancer
6. Monitoring & logging using CloudWatch


## Tools & Services Used

- React (frontend app)
- Docker (containerization)
- Amazon ECR (container registry)
- Amazon EKS (Kubernetes cluster)
- Kubectl (Kubernetes CLI)
- AWS CodeBuild & CodePipeline (CI/CD)
- AWS CloudWatch (monitoring & logs)
- GitHub (version control)

---

## 1. Clone & Run App Locally

git clone https://github.com/Vennilavan12/Brain-Tasks-App.git
cd Brain-Tasks-App
npm install
npm start

2. Dockerize the Application

Dockerfile :

Build & Run Docker Container:

docker build -t brain-tasks-app .
docker run -p 3000:3000 brain-tasks-app

website URL: http://54.176.59.144:3000

3. Push Docker Image to AWS ECR
aws ecr create-repository --repository-name brain-tasks-app

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION=<your-region>
IMAGE_URI=$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/brain-tasks-app:latest

aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com
docker tag brain-tasks-app:latest $IMAGE_URI
docker push $IMAGE_URI

4. Setup Kubernetes (EKS)
eksctl create cluster --name brain-tasks-cluster --region <your-region> --nodes 2
aws eks update-kubeconfig --name brain-tasks-cluster --region <your-region>
kubectl get nodes

5. Kubernetes Deployment

deployment.yaml

service.yaml

Deploy:

kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl get svc


Note: LoadBalancer URL will appear under EXTERNAL-IP.

Loadbalancer URL : http://a3a179c9c14a04ab7b324b31f91df164-1272909025.us-west-1.elb.amazonaws.com

6. Automate with CodeBuild & CodePipeline

buildspec.yml

Pipeline Flow:

Source: GitHub repo

Build: CodeBuild builds Docker image, pushes to ECR, updates Kubernetes

Deploy: Automatic via CodeBuild step

7. Monitoring & Logs

Build & Pipeline Logs: AWS CloudWatch

Pod Logs: kubectl logs <pod-name> or forward to CloudWatch via Fluent Bit

Metrics: CPU, memory, and pod health using Container Insights
