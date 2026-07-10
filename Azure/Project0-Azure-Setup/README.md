Progress Snapshot
Cloud Engineer Lab v1.0

Project0：Azure Environment Setup

Step1 Azureアカウント作成
✅ 完了

Step2 Azure Portal確認
✅ Portalログイン
✅ Subscription確認
✅ Resource Group作成
✅ Japan East選択

Step3 開発環境構築
✅ Azureフォルダ構成決定
✅ Project0フォルダ作成
✅ README配置場所決定
🔄 Azure CLIインストール中
⬜ Azure CLIログイン
⬜ Azure PowerShell導入
⬜ VS Code Azure拡張機能

次回予定
➡ Step4：Azure CLI（az login → az account show）
## Step4 Azure CLI導入

### 実施内容

- Azure CLI 2.88.0 をインストール
- `az version` による動作確認
- `az login` によるAzure認証

### 使用コマンド

```powershell
az version
az login
## Step4 Azure CLI

### 実施内容

- Azure CLI 2.88.0 インストール
- Azure CLIログイン
- サブスクリプション確認

### 使用コマンド

```powershell
az version
az login
az account show
## Step5 Azure CLI基本操作

### 実施内容

- Resource Group一覧取得
- Resource Group詳細取得

### 使用コマンド

```powershell
az group list --output table
az group show --name rg-cloudlab-dev-001 --output table
az group show --name rg-cloudlab-dev-001
```

### 学んだこと

- Azure CLIはAzure Resource Manager (ARM)と通信している
- `list` は一覧取得、`show` は1つのリソースの詳細取得に使用する
- `--output table` は人が見やすく、JSONは自動化に向いている
## Step6 Azure CLIでResource Group作成

### 実施内容

- Azure CLIでResource Groupを新規作成
- 作成後に一覧で確認

### 使用コマンド

```powershell
az group create --name rg-cloudlab-test-001 --location japaneast
az group list --output table
```

### 学んだこと

- Azure CLIからResource Groupを作成できる
- 実務では検証用(Resource Group)で試してから本番へ反映する