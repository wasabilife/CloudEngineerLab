# ============================================
# Get-EC2ReportCsv.ps1
# EC2情報取得・CSV出力・S3アップロード
# ============================================


# ============================================
# パス設定
# ============================================

# AWS\Automate\Scripts
$ScriptDirectory = $PSScriptRoot


# Scripts → Automate
$AutomateDirectory = Split-Path $ScriptDirectory -Parent


# Reports
$ReportDirectory = Join-Path $AutomateDirectory "Reports"


# Reports\EC2
$EC2ReportDirectory = Join-Path $ReportDirectory "EC2"


# ExecutionLogs
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

        throw "AWS CLIがインストールされていません"
    }



    # ========================================
    # AWS認証確認
    # ========================================

    aws sts get-caller-identity | Out-Null


    if ($LASTEXITCODE -ne 0) {

        throw "AWS認証に失敗しました"
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



    Add-Content `
        $ExecutionLogFile `
        "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') CSV作成成功"



    Add-Content `
        $ExecutionLogFile `
        "保存先: $ReportPath"



    # ========================================
    # S3アップロード
    # ========================================

    $BucketName = "cloud-engineer-lab-wasabi-520819077064-ap-northeast-3-an"



    # S3保存用日時
    $UploadDate = Get-Date -Format "yyyy/MM/dd"

    $FileDate = Get-Date -Format "yyyyMMdd_HHmmss"



    # S3キー
    $S3Key = "EC2/$UploadDate/EC2Report_$FileDate.csv"



    aws s3 cp `
        $ReportPath `
        "s3://$BucketName/$S3Key"



    if ($LASTEXITCODE -ne 0) {

        throw "S3アップロードに失敗しました"
    }



    Add-Content `
        $ExecutionLogFile `
        "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') S3アップロード成功"



    Add-Content `
        $ExecutionLogFile `
        "保存先: s3://$BucketName/$S3Key"



    # ========================================
    # 完了表示
    # ========================================

    Write-Host ""
    Write-Host "================================"
    Write-Host "EC2レポート作成完了"
    Write-Host "================================"
    Write-Host ""
    Write-Host "ローカル:"
    Write-Host $ReportPath
    Write-Host ""
    Write-Host "S3:"
    Write-Host "s3://$BucketName/$S3Key"



    # ========================================
    # 正常終了ログ
    # ========================================

    Add-Content `
        $ExecutionLogFile `
        "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') 正常終了"

}



catch {


    # ========================================
    # エラー処理
    # ========================================

    Add-Content `
        $ExecutionLogFile `
        "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') エラー発生"



    Add-Content `
        $ExecutionLogFile `
        $_.Exception.Message



    Write-Host ""
    Write-Host "エラーが発生しました"
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