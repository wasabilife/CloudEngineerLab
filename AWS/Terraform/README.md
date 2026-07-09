## Step2 VPC Infrastructure Creation

### Overview
Terraformを利用してAWS VPC環境をコード管理で構築。

### Created Resources

- VPC
- Internet Gateway
- Public Subnet
- Route Table
- Route Table Association

### Validation

Terraform実行結果:

terraform plan
→ Success

terraform apply
→ Success

AWS Management Consoleにて作成確認済み。

### Skills Learned

- Terraform基本操作
- AWSネットワーク基礎
- Infrastructure as Code(IaC)
- TerraformによるAWSリソース管理