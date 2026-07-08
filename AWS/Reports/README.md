# EC2 CSV Report

## 目的

PowerShellとAWS CLIを利用して、EC2の情報をCSV形式で出力する。

## 実施内容

- AWS CLIでEC2情報を取得
- JSONをPowerShellオブジェクトへ変換
- Nameタグ、InstanceId、State、InstanceType、PublicIPを抽出
- CSVファイルを生成

## 学んだこと

- AWS CLIのJSONはPowerShellで自由に加工できる。
- ConvertFrom-Jsonを利用するとオブジェクトとして扱える。
- Export-Csvを利用するとExcelで扱いやすいレポートを作成できる。

## 実務での利用例

- EC2資産管理
- 定期レポート作成
- 稼働状況の確認
- インベントリ管理