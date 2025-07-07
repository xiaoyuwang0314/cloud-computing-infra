# Cloud Infrastructure Project

This project implements a cloud infrastructure using Terraform on AWS. It sets up a complete environment including VPC, EC2 instances, load balancing, auto-scaling, and database components.

## 🔗 Related Repositories

- **Frontend** (React + Vite + D3 + JWT Auth):  
  🎨 [movie-recommendation-app-frontend](https://github.com/xiaoyuwang0314/movie-recommendation-app-frontend)

- **~Live Site~** Temporarily closed:  
  🌐 [https://frontend.justanotherapp.me](https://frontend.justanotherapp.me)

- **Backend** (Spring Boot + RESTful API + Auth):  
  ⚙️ [cloud-native-web-application](https://github.com/xiaoyuwang0314/cloud-computing-project/tree/main/cloud-native-web-application)

- **Note**:  
  ⚠️ While this project contains full-stack provisioning (CloudWatch, NLB, multi-instance setup), the current deployment is simplified (e.g., single EC2 + Nginx) to reduce AWS cost.

## Project Structure

The infrastructure is defined using multiple Terraform configuration files:

- `vpc.tf`: Virtual Private Cloud configuration
- `iam.tf`: IAM roles and policies
- `security.tf`: Security groups and network access rules
- `launch_template.tf`: EC2 instance launch templates
- `autoscaling.tf`: Auto-scaling group configuration
- `database.tf`: MySQL database setup
- `nlb.tf`: Network Load Balancer configuration
- `route53.tf`: DNS configuration
- `key.tf`: Key pair management
- `variables.tf`: Variable definitions
- `outputs.tf`: Output values
- `terraform.tfvars`: Variable values

## Prerequisites

- AWS account with appropriate permissions
- Terraform installed (version >= 1.0.0)
- AWS CLI configured with appropriate credentials
- GitHub repository with appropriate secrets configured:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `DATABASE_PASSWORD`
  - `WEBAPP_SECRET_KEY`
  - `ADMIN_USER`
  - `ADMIN_PASS`
- GitHub repository variables:
  - `WEBAPP_AMI_ID`
  - `MYSQL_AMI_ID`
  - `DATABASE_USERNAME`

## Required Variables

The following variables need to be set in `terraform.tfvars`:

- `webapp_ami_id`: AMI ID for the WebApp EC2 instances
- `mysql_ami_id`: AMI ID for the MySQL EC2 instance
- `database_username`: Username for MySQL database
- `database_password`: Password for MySQL database
- `webapp_secret_key`: Secret key used by WebApp
- `domain_name`: Domain name for the application

## Default Configuration

- Region: us-east-2
- Instance Type: t2.micro

## Usage

### Manual Deployment

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Review the execution plan:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

4. To destroy the infrastructure:
   ```bash
   terraform destroy
   ```

### Automated Deployment (CI/CD)

The project includes a GitHub Actions workflow (`integration_tests.yml`) that automates the deployment and testing process:

1. The workflow can be triggered manually through GitHub Actions
2. It performs the following steps:
   - Sets up AWS credentials
   - Initializes and validates Terraform
   - Applies the infrastructure
   - Runs integration tests
   - Automatically destroys the infrastructure after testing

## Infrastructure Components

- **VPC**: Virtual Private Cloud with public and private subnets
- **EC2 Instances**: Web application and MySQL database instances
- **Load Balancer**: Network Load Balancer for traffic distribution
- **Auto Scaling**: Automatic scaling of web application instances
- **Security Groups**: Network security rules
- **IAM Roles**: Access control and permissions
- **Route 53**: DNS management
- **Key Pairs**: SSH access management

## Security Considerations

- Sensitive variables (database password, webapp secret key) are marked as sensitive
- Security groups are configured to restrict access
- IAM roles follow the principle of least privilege
- Secrets are managed through GitHub Secrets
- AWS credentials are securely handled in the CI/CD pipeline

## Testing

The project includes a test directory (`movie_endpoint_test/`) for testing the webapp. Tests are automatically run as part of the CI/CD pipeline and include:
- Integration tests
- Endpoint validation
- Authentication tests

## License

This project is part of a course assignment and should be used in accordance with the course guidelines.
