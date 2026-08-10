# Project2: Azure Operations Automation

## Overview

Azure CLIとPowerShellを使用して、
Azure VMの運用情報を自動取得し、
CSVレポートとして出力する運用自動化ツール。

## Objective

Azure VMの状態確認などの定型運用作業を自動化し、
以下の情報をCSV形式で取得する。

- VM Name
- Resource Group
- Location
- VM Size
- Power State
- Private IP
- Public IP

## Architecture

Azure
  ↓
Azure CLI
  ↓
PowerShell
  ↓
CSV Report

## Directory Structure

```text
Project2-Azure-Automation
│
├── Scripts
│   └── Get-AzureVMReport.ps1
│
├── Reports
│   └── AzureVMReport.csv
│
├── ExecutionLogs
│   └── Automation.log
│
└── README.md