# GKE with Nginx Deployment and Global Load Balancer (Modular)

This repository contains a modular Terraform configuration to set up a Google Kubernetes Engine (GKE) cluster on Google Cloud, deploy an Nginx application, and configure a Global HTTP Load Balancer using Google Cloud's Network Endpoint Groups (NEG). The infrastructure is modularized for better organization and scalability.

## Prerequisites

Before using this repository, ensure that you have the following:

- **Google Cloud account** with the appropriate permissions.
- **Terraform** installed. You can install it from [Terraform's website](https://www.terraform.io/downloads.html).
- **Google Cloud SDK** installed and authenticated. Follow [Google Cloud SDK installation instructions](https://cloud.google.com/sdk/docs/install).

## Project Overview

The repository is organized into multiple Terraform modules to create reusable and scalable infrastructure components:

1. **`modules/vpc`**: Configures the Virtual Private Cloud (VPC) and its subnets (public and private).
2. **`modules/service_account`**: Sets up a service account for the GKE cluster with the necessary permissions.
3. **`modules/gke`**: Deploys a Google Kubernetes Engine (GKE) cluster, including node pools and configurations.
4. **`modules/nginx_app`**: Deploys an Nginx application on the GKE cluster.
5. **`modules/load_balancer`**: Configures a Global HTTP Load Balancer with Network Endpoint Groups (NEG) to route traffic to the Nginx app.

## Setup and Usage

Follow these steps to deploy the infrastructure.

### 1. Clone the Repository

Start by cloning the repository to your local machine:

```bash
git clone <your-repo-url>
cd <your-repo-directory>
```

### 2. Configure Google Cloud Provider

In the main.tf file, the provider is set to Google Cloud (google provider). Ensure that the project ID and region are correctly configured for your Google Cloud account:

```bash
provider "google" {
  region  = var.region          # Update region if needed
  project = var.project_id      # Replace with your actual Google Cloud project ID
}
```

### 3. Configure Variables

Make sure you configure the necessary variables in the **`variables.tf`** file. Key variables include:

1. **`project_id`**: Your Google Cloud project ID.
2. **`region`**: The region for your infrastructure (e.g., **`us-west1`**).
3. **`vpc_name`**: Name of the VPC to create.
4. **`cluster_name`**: The name of the GKE cluster.
5. **`node_count`**: Number of nodes in the GKE cluster.
You can modify the variables.tf or create a .tfvars file to pass values.


### 4. Authenticate Google Cloud

Ensure that you are authenticated with Google Cloud by running:

```bash
gcloud auth login
gcloud config set project <your-project-id>
```

### 5. Initialize Terraform

Run the following command to initialize the Terraform configuration:

```bash
terraform init
```

### 6. Apply the Terraform Configuration

To create the resources, apply the Terraform plan:

```bash
terraform apply
```

You can run **`terraform plan`** before running **`terraform apply`** to see what changes will be made.


### 7. Verify the Deployment

Once the infrastructure is deployed, you can check the status of the GKE cluster and other resources using the Google Cloud Console or gcloud CLI. The application should be available through a global IP created by Terraform.

### 8. Clean Up

To delete the created resources when you no longer need them, run the following command:

```bash
terraform destroy
```

This will remove all the resources created by Terraform.






