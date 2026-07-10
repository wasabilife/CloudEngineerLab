# Step1 Virtual Network

## 目的

Azure Virtual Network（VNet）を作成し、今後構築するSubnetやVirtual Machineのネットワーク基盤を準備する。

## 作成したリソース

|項目|値|
|---|---|
|Virtual Network|vnet-cloudlab-dev-001|
|Resource Group|rg-cloudlab-dev-001|
|Location|Japan East|
|Address Space|10.10.0.0/16|

## 実行コマンド

```powershell
az network vnet create `
  --resource-group rg-cloudlab-dev-001 `
  --name vnet-cloudlab-dev-001 `
  --address-prefixes 10.10.0.0/16 `
  --location japaneast
```

## 確認コマンド

```powershell
az network vnet list --output table

az network vnet show `
  --resource-group rg-cloudlab-dev-001 `
  --name vnet-cloudlab-dev-001
```

## 学んだこと

- VNetはAzureネットワークの基盤
- AWSではVPCに相当する
- CIDRは将来の拡張を考えて設計する
- Resource IDはAzureリソースの一意な識別子