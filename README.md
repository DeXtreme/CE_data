# CE_data
Azubi week 17 assignment: Data Dilemma

### Problem Statement: 
You're tasked with creating data storage solutions using Amazon EBS and EFS for different use cases.

### Guidelines/Goals:
- Amazon EBS Setup:
  - Create an Amazon EBS volume and attach it to an EC2 instance.
  - Format and mount the volume to a specific directory.
  - Create a simple text file on the EBS volume.
    
- Amazon EFS Setup:
  - Create an Amazon EFS file system.
  - Mount the file system on multiple EC2 instances.
  - Create a file on one instance and verify its presence on another.

## Usage

### Requirements
  - Terraform
  - Ansible

### Instructions
1. Clone the repo
2. Initialize terraform
    ```
    terraform init
    ```
3. Apply the configuration
    ```
    terraform apply
    ```

