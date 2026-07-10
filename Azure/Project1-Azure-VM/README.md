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
# Step2 Subnet

## 目的

Virtual Machineを配置するためのSubnetを作成した。

## 作成したリソース

|項目|値|
|---|---|
|Subnet|subnet-web-001|
|Virtual Network|vnet-cloudlab-dev-001|
|Address Prefix|10.10.1.0/24|

## 実行コマンド

```powershell
az network vnet subnet create `
  --resource-group rg-cloudlab-dev-001 `
  --vnet-name vnet-cloudlab-dev-001 `
  --name subnet-web-001 `
  --address-prefixes 10.10.1.0/24
```

## 確認コマンド

```powershell
az network vnet subnet list `
  --resource-group rg-cloudlab-dev-001 `
  --vnet-name vnet-cloudlab-dev-001 `
  --output table

az network vnet subnet show `
  --resource-group rg-cloudlab-dev-001 `
  --vnet-name vnet-cloudlab-dev-001 `
  --name subnet-web-001
```

## 学んだこと

- Virtual MachineはSubnet内に配置される
- VNetは複数Subnetに分割できる
- Subnetを役割ごとに分けることでセキュリティと運用性が向上する
- CIDR設計は将来の拡張を考慮して行う
# Step3 Network Security Group

## 目的

Virtual Machineへの通信を制御するため、Network Security Group（NSG）を作成し、Subnetへ関連付けた。

## 作成したリソース

|項目|値|
|---|---|
|NSG|nsg-web-001|
|Subnet|subnet-web-001|

## 実行コマンド

```powershell
az network nsg create `
  --resource-group rg-cloudlab-dev-001 `
  --name nsg-web-001 `
  --location japaneast
```

```powershell
az network nsg rule create `
  --resource-group rg-cloudlab-dev-001 `
  --nsg-name nsg-web-001 `
  --name Allow-SSH `
  --priority 1000 `
  --direction Inbound `
  --access Allow `
  --protocol Tcp `
  --destination-port-ranges 22 `
  --source-address-prefixes Internet `
  --source-port-ranges "*"
```

```powershell
az network vnet subnet update `
  --resource-group rg-cloudlab-dev-001 `
  --vnet-name vnet-cloudlab-dev-001 `
  --name subnet-web-001 `
  --network-security-group nsg-web-001
```

## 学んだこと

- NSGはAzureの仮想ファイアウォールである
- AWS Security Groupに相当する
- NSGはSubnetまたはNICに関連付けられる
- 今回はSubnet単位で適用し、管理しやすい構成とした
- 通信ルールは最小権限の原則で設定する
# Step4 Public IP

## 目的

Virtual Machineへインターネット経由で接続するため、Public IPを作成した。

## 作成したリソース

|項目|値|
|---|---|
|Public IP|pip-vm-web-001|
|SKU|Standard|
|Allocation|Static|

## 実行コマンド

```powershell
az network public-ip create `
  --resource-group rg-cloudlab-dev-001 `
  --name pip-vm-web-001 `
  --sku Standard `
  --allocation-method Static `
  --location japaneast
```

## 確認コマンド

```powershell
az network public-ip list --output table

az network public-ip show `
  --resource-group rg-cloudlab-dev-001 `
  --name pip-vm-web-001
```

## 学んだこと

- Public IPはAzureでは独立したリソースである
- VMへ後から関連付けることができる
- Standard SKUが実務では推奨される
- Staticを利用することでIPアドレスを固定できる