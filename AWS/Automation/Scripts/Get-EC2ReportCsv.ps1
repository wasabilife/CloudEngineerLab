# EC2情報取得
$instances = aws ec2 describe-instances | ConvertFrom-Json

$result = foreach ($reservation in $instances.Reservations) {
    foreach ($instance in $reservation.Instances) {

        $name = ($instance.Tags | Where-Object {$_.Key -eq "Name"}).Value

        [PSCustomObject]@{
            Name         = $name
            InstanceId   = $instance.InstanceId
            State        = $instance.State.Name
            InstanceType = $instance.InstanceType
            PublicIP     = $instance.PublicIpAddress
        }
    }
}

$ReportPath = ".\AWS\Reports\EC2\EC2Report.csv"

$result | Export-Csv $ReportPath -NoTypeInformation -Encoding UTF8

Write-Host "CSVを作成しました。"