# AWS EC2 Report Automation

## 概要
AWS CLIを利用してEC2情報を取得し、
CSVレポートを自動生成するPowerShellスクリプトです。

## 構成

Automate
├─ Scripts
│   └─ Get-EC2ReportCsv.ps1
├─ Reports
│   └─ EC2
│       └─ EC2Report.csv
└─ ExecutionLogs
    └─ Automation.log


## 実行方法

1. AWS CLI設定済み環境で実行

.\Get-EC2ReportCsv.ps1


## 出力内容

EC2一覧をCSV形式で出力します。

項目:
- Name
- InstanceId
- State
- InstanceType
- PublicIP


## ログ

実行結果は以下に保存されます。

ExecutionLogs\Automation.log