# スクリプトのある場所
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Reportsフォルダ
$ReportDir = Join-Path $ScriptDir "..\Reports"

# フォルダ作成
if (!(Test-Path $ReportDir)) {
    New-Item -ItemType Directory -Path $ReportDir | Out-Null
}

# 日付
$Date = Get-Date -Format "yyyyMMdd-HHmmss"

# 出力ファイル
$OutputFile = Join-Path $ReportDir "EC2Report-$Date.txt"

aws ec2 describe-instances `
--query "Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,PublicIpAddress]" `
--output table > $OutputFile

Write-Host "保存先:"
Write-Host $OutputFile