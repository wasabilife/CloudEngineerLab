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