### 1. S3 Backend 생성

```sh
cd 01_service/00_backend_svc

01_service/00_backend_svc$ terraform init
01_service/00_backend_svc$ terraform plan -var-file=00.test.tfvars
01_service/00_backend_svc$ terraform apply -var-file=00.test.tfvars
```

<br>

### 2. VPC 생성

```sh
cd 01_service/01_vpc_svc

01_service/01_vpc_svc$ terraform init
01_service/01_vpc_svc$ terraform plan -var-file=./00.envs/00.test.tfvars
01_service/01_vpc_svc$ terraform apply -var-file=./00.envs/00.test.tfvars
```

<br>

### 3. EC2 생성 (ALB, ASG)

```sh
cd 01_service/02_ec2_svc

01_service/02_ec2_svc$ terraform init
01_service/02_ec2_svc$ terraform plan -var-file=./00.envs/00.test.tfvars
01_service/02_ec2_svc$ terraform apply -var-file=./00.envs/00.test.tfvars
```
