# EC2

## 学習日

2026-07-08

---

## 目的

AWS CLIを利用してEC2インスタンスの情報を取得し、CLIでAWSリソースを管理する方法を学ぶ。

---

## 実施内容

### EC2一覧を取得

```powershell
aws ec2 describe-instances
```

### 必要な情報だけを表形式で表示

```powershell
aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,PublicIpAddress]" --output table
```

### テキストファイルへ出力

```powershell
aws ec2 describe-instances `
  --query "Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,PublicIpAddress]" `
  --output text > ec2list.txt
```

---

## 実行結果

- EC2のインスタンスIDを取得できた
- インスタンスタイプを確認できた
- ステータス（running）を確認できた
- パブリックIPアドレスを取得できた

---

## 学んだこと

- `describe-instances` はEC2の詳細情報を取得するコマンドである。
- `--query` を使うことで、必要な項目だけを抽出できる。
- `--output table` を使うと、人が見やすい形式で表示できる。
- CLIを使うことでGUIを開かずに情報取得ができる。

---

## 実務での利用例

- EC2インスタンスの棚卸し
- 稼働状況の確認
- サーバー一覧の作成
- 運用レポートの作成
- PowerShellやバッチ処理による自動化

---

## 気づき

AWS CLIを利用すると、GUIよりも素早く必要な情報を取得できることが分かった。
今後は取得した情報をCSVへ出力し、PowerShellと組み合わせて自動化を進めていきたい。
## EC2の起動・停止

### 停止

```powershell
aws ec2 stop-instances --instance-ids <InstanceId>
```

### 起動

```powershell
aws ec2 start-instances --instance-ids <InstanceId>
```

### 状態確認

```powershell
aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,State.Name]" --output table
```

### 学んだこと

- CLIからEC2の起動・停止ができる。
- 状態確認は `describe-instances` で行える。
- GUIを開かなくてもサーバー運用が可能。