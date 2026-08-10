# Project3 - Terraform Azure Environment Automation

## Overview

Terraformを使用してAzure環境をコードで管理するためのプロジェクト。

本プロジェクトでは、Azure CLIとTerraform AzureRM Providerを利用し、
Azure Infrastructure as Code（IaC）を実践する。

## Objective

- TerraformによるAzure環境構築
- Infrastructure as Code（IaC）の理解
- Azure Providerの利用
- TerraformによるInfrastructure管理
- Git/GitHubによるコード管理
- Azure Cloud Engineer向けポートフォリオ作成

## Environment

- OS: Windows 11
- Shell: PowerShell
- Cloud: Microsoft Azure
- Region: Japan East
- IaC: Terraform
- Provider: AzureRM
- CLI: Azure CLI
- Repository: GitHub

## Step1: Terraform Environment Initialization

### Completed

- Terraform installation verified
- Azure CLI installation verified
- Azure subscription authentication verified
- AzureRM Provider configured
- Terraform initialization completed
- Terraform validation completed
- Terraform formatting completed
- Terraform plan completed
- Terraform provider configuration verified

### Resources Created

Step1ではAzureリソースを新規作成していない。

そのため、本StepではAzureリソースによる追加課金は発生しない。

## Terraform Structure

```text
Project3-Terraform-Azure/
├─ provider.tf
├─ variables.tf
├─ main.tf
├─ outputs.tf
├─ README.md
├─ .gitignore
└─ terraform.tfvars