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

# AWS EC2 Report Automation

## 概要

AWS CLIを利用してEC2情報を取得し、
CSV形式のレポートを自動生成するPowerShellスクリプトです。

Windowsタスクスケジューラと組み合わせることで、
定期的なEC2リソース棚卸しを自動実行できます。

## 作成目的

AWS運用業務では、サーバー情報確認や資産管理などの定期作業が発生します。

本ツールでは、以下の運用作業を自動化することを目的として作成しました。

* EC2インスタンス情報取得
* CSVレポート作成
* 実行ログ記録
* 定期実行

## 使用技術

| 技術                     | 用途          |
| ---------------------- | ----------- |
| AWS CLI                | AWSリソース情報取得 |
| PowerShell             | 自動化スクリプト作成  |
| Windows Task Scheduler | 定期実行        |
| Git / GitHub           | ソースコード管理    |

## 構成

```
Automation
├─ Scripts
│   └─ Get-EC2ReportCsv.ps1
│
├─ Reports
│   └─ EC2
│       └─ EC2Report.csv
│
└─ ExecutionLogs
    └─ Automation.log
```

## 処理フロー

```
Windows Task Scheduler
          |
          ↓
PowerShell Script実行
          |
          ↓
AWS CLIでEC2情報取得
          |
          ↓
CSVレポート生成
          |
          ↓
Reportsへ保存
          |
          ↓
ExecutionLogsへ実行結果記録
```

## 実行方法

AWS CLI設定済み環境で実行します。

```powershell
.\Get-EC2ReportCsv.ps1
```

またはWindowsタスクスケジューラから定期実行します。

## 出力内容

EC2一覧をCSV形式で出力します。

取得項目:

* Name
* InstanceId
* State
* InstanceType
* PublicIP

## ログ

実行結果は以下に保存されます。

```
ExecutionLogs\Automation.log
```

記録内容:

* 実行開始日時
* CSV作成結果
* 保存先
* 終了状態

## 自動実行設定

Windowsタスクスケジューラを利用して、
PowerShellスクリプトを定期実行します。

設定内容:

* 実行方式：毎日
* 実行ユーザー：Windowsユーザー
* 実行処理：Get-EC2ReportCsv.ps1

## 今後の改善予定

今後、以下の機能追加を予定しています。

* [ ] try/catchによるエラー処理追加
* [ ] エラー内容のログ記録
* [ ] Amazon S3へのレポート自動保存
* [ ] CloudWatch Logs連携
* [ ] 実行結果通知機能追加

## 作成目的

AWS環境における定型運用作業を自動化し、
運用負荷削減と作業品質向上を目的として作成しました。

# AWS EC2 Report Automation

## 概要

AWS CLIとPowerShellを利用して、EC2インスタンス情報を取得し、CSV形式の運用レポートを自動生成するツールです。

取得したレポートはローカル保存およびAmazon S3へアップロードし、Windowsタスクスケジューラによる定期実行に対応しています。

AWS運用業務で発生するサーバー棚卸し作業の自動化を目的として作成しました。

## 作成目的

AWS環境では、定期的なEC2インスタンス情報確認や資産管理が必要になります。

本ツールでは以下の運用作業を自動化しました。

* EC2インスタンス情報取得
* Nameタグ取得
* CSVレポート作成
* 停止中EC2インスタンス抽出
* Amazon S3へのレポート保存
* 実行ログ記録
* 定期自動実行

## 使用技術

| 技術                     | 用途           |
| ---------------------- | ------------ |
| AWS CLI                | EC2情報取得、S3操作 |
| PowerShell             | 自動化スクリプト作成   |
| Amazon EC2             | 管理対象リソース     |
| Amazon S3              | レポート保存先      |
| Windows Task Scheduler | 定期実行         |
| Git / GitHub           | ソースコード管理     |

## ディレクトリ構成

```
Automation
├─ Scripts
│   └─ Get-EC2ReportCsv.ps1
│
├─ Reports
│   └─ EC2
│       ├─ EC2Report.csv
│       └─ StoppedEC2Report.csv
│
├─ ExecutionLogs
│   └─ Automation.log
│
└─ README.md
```

## 処理フロー

```
Windows Task Scheduler
        |
        ↓
PowerShell Script実行
        |
        ↓
AWS CLI認証確認
        |
        ↓
EC2情報取得
        |
        ↓
Nameタグ取得
        |
        ↓
CSVレポート作成
        |
        ↓
停止中EC2抽出
        |
        ↓
S3へアップロード
        |
        ↓
ExecutionLogsへ実行結果記録
```

## 出力ファイル

### EC2Report.csv

全EC2インスタンス情報を出力します。

取得項目：

* Name
* InstanceId
* State
* InstanceType
* PublicIP

### StoppedEC2Report.csv

停止状態（stopped）のEC2のみ抽出します。

## S3保存形式

S3へ以下の形式で保存します。

```
EC2/
└── YYYY/
    └── MM/
        └── DD/
            ├── EC2Report_xxxxxx.csv
            └── StoppedEC2Report_xxxxxx.csv
```

## ログ

実行結果は以下へ保存されます。

```
ExecutionLogs\Automation.log
```

記録内容：

* 実行開始日時
* CSV作成結果
* S3アップロード結果
* エラー内容
* 正常終了状態

## 自動実行

Windowsタスクスケジューラを利用し、定期的にスクリプトを実行します。

実行例：

```
毎日 09:00
↓
Get-EC2ReportCsv.ps1実行
↓
EC2棚卸しレポート作成
```

## エラー処理

PowerShellのtry/catch/finallyを利用し、以下の異常を検知します。

* AWS CLI未導入
* AWS認証失敗
* EC2情報取得失敗
* S3アップロード失敗

発生したエラー内容はExecutionLogsへ記録します。

## 今後の改善予定

* [ ] CloudWatch Logs連携
* [ ] SNS通知機能追加
* [ ] IAM Roleによる認証方式変更
* [ ] 複数AWSアカウント対応
* [ ] HTMLレポート化

## 作成目的

AWS環境における定型運用作業を自動化し、運用負荷削減、作業品質向上、手作業によるミス削減を目的として作成しました。
