# ============================================
# Get-EC2ReportCsv.ps1
# EC2情報取得・CSV出力スクリプト
# ============================================


# ============================================
# パス設定
# ============================================

# スクリプトの場所
# AWS\Automate\Scripts
$ScriptDirectory = $PSScriptRoot


# Automateフォルダ取得
# Scripts → Automate
$AutomateDirectory = Split-Path $ScriptDirectory -Parent


# Reportsフォルダ
$ReportDirectory = Join-Path $AutomateDirectory "Reports"


# EC2レポートフォルダ
# 実行時に自動作成
$EC2ReportDirectory = Join-Path $ReportDirectory "EC2"


# ExecutionLogsフォルダ
$ExecutionLogDirectory = Join-Path $AutomateDirectory "ExecutionLogs"



# ============================================
# フォルダ作成
# ============================================

foreach ($directory in @(
    $ReportDirectory,
    $EC2ReportDirectory,
    $ExecutionLogDirectory
)) {

    if (!(Test-Path $directory)) {

        New-Item `
            -ItemType Directory `
            -Path $directory `
            | Out-Null
    }
}



# ============================================
# ログ設定
# ============================================

$ExecutionLogFile = Join-Path `
    $ExecutionLogDirectory `
    "Automation.log"


Add-Content `
    $ExecutionLogFile `
    ""

Add-Content `
    $ExecutionLogFile `
    "===== $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') 開始 ====="



try {


    # ========================================
    # AWS CLI確認
    # ========================================

    aws --version | Out-Null


    if ($LASTEXITCODE -ne 0) {

        throw "AWS CLIが利用できません"
    }



    # ========================================
    # EC2情報取得
    # ========================================

    $instancesJson = aws ec2 describe-instances


    if ($LASTEXITCODE -ne 0) {

        throw "EC2情報取得に失敗しました"
    }


    $instances = $instancesJson | ConvertFrom-Json



    # ========================================
    # EC2情報整形
    # ========================================

    $result = foreach ($reservation in $instances.Reservations) {

        foreach ($instance in $reservation.Instances) {


            $name = (
                $instance.Tags |
                Where-Object {
                    $_.Key -eq "Name"
                }
            ).Value



            [PSCustomObject]@{

                Name = $name

                InstanceId = $instance.InstanceId

                State = $instance.State.Name

                InstanceType = $instance.InstanceType

                PublicIP = $instance.PublicIpAddress

            }

        }

    }



    # ========================================
    # CSV出力
    # ========================================

    $ReportPath = Join-Path `
        $EC2ReportDirectory `
        "EC2Report.csv"



    $result |
        Export-Csv `
            -Path $ReportPath `
            -NoTypeInformation `
            -Encoding UTF8



    Write-Host ""
    Write-Host "CSVを作成しました。"
    Write-Host "保存先:"
    Write-Host $ReportPath



    # ========================================
    # 正常終了ログ
    # ========================================

    Add-Content `
        $ExecutionLogFile `
        "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') 正常終了"


    Add-Content `
        $ExecutionLogFile `
        "出力ファイル: $ReportPath"



}



catch {


    # ========================================
    # エラーログ
    # ========================================

    Add-Content `
        $ExecutionLogFile `
        "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') エラー発生"


    Add-Content `
        $ExecutionLogFile `
        $_.Exception.Message



    Write-Host ""
    Write-Host "エラーが発生しました。"
    Write-Host $_.Exception.Message

}



finally {


    Add-Content `
        $ExecutionLogFile `
        "===== $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') 終了 ====="


    Add-Content `
        $ExecutionLogFile `
        ""

}