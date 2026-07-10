## Project Overview

Terraform Remote Backend用の基盤を構築する。

## Purpose

Terraform StateをローカルPCではなくAWS S3で管理することで、チーム開発やバックアップに対応する。

## Resources

- Amazon S3 Bucket
- S3 Versioning
- S3 Server Side Encryption

## Why Versioning?

Stateファイルを誤って更新・削除した場合でも、以前のバージョンへ復元できる。

## Why Encryption?

Terraform Stateにはインフラ構成情報が含まれるため、S3上で暗号化して保護する。
## Remote Backend Preparation

### Created Resources

- Amazon S3 Bucket
- S3 Bucket Versioning
- S3 Server-Side Encryption (AES256)

### Purpose

Terraform Stateを安全に保存するためのRemote Backend用S3バケットを構築。

### Verification

- terraform validate：Success
- terraform plan：3 resources to add
- AWS ConsoleでVersioning有効を確認
- AWS ConsoleでDefault Encryption有効を確認
### Terraform Remote Backend

#### Purpose
Terraform StateをローカルPCではなくAWS S3で管理するための基盤を構築。

#### Resources
- Amazon S3 Bucket
- S3 Versioning
- S3 Server-Side Encryption (AES256)

#### Why?
- チーム開発でStateを共有するため
- Stateファイルのバックアップを保持するため
- Stateファイルを暗号化して保護するため
### Troubleshooting

#### Issue
GitHub rejected the push because the `.terraform` directory contained the AWS provider executable (over 100 MB).

#### Cause
The `Terraform-Backend` project did not have a `.gitignore`, so the `.terraform` directory was accidentally committed.

#### Resolution
- Added a `.gitignore`
- Excluded `.terraform` and `*.tfstate`
- Removed the files from Git tracking
- Recreated the commit without the provider binaries

#### Lesson Learned
Always create `.gitignore` before running `terraform init` in a new Terraform project.
## DynamoDB State Lock

### Purpose

Prevent multiple users from modifying the Terraform State at the same time.

### Why?

When multiple engineers execute `terraform apply` simultaneously, the Terraform State may become inconsistent.

DynamoDB provides a locking mechanism to ensure only one operation updates the State at a time.
## Remote Backend Migration

### Purpose

Store Terraform State in Amazon S3 instead of the local machine.

### Components

- Amazon S3
- DynamoDB State Lock

### Migration

Executed:

terraform init -migrate-state

Result:

Local terraform.tfstate was migrated to the S3 Remote Backend.

### Benefits

- Shared Terraform State
- Prevents concurrent updates
- Team collaboration
- State versioning
Project Summary
Terraform Remote Backendを構築
Amazon S3へStateを移行
DynamoDBでState Lockを実装
Troubleshooting
.terraform を誤ってコミットした原因と対策
Backend設定前にDynamoDBが存在せず発生したエラー
terraform init -migrate-state によるState移行
Lessons Learned
Backendはブートストラップ手順で構築する
.terraform と terraform.tfstate は通常Git管理しない
Gitのstatus確認を徹底する重要性