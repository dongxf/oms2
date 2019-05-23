Set-Executionpolicy remotesigned
$homeDir = "d:\dongxf\work\oms2"
#$homeDir = "c:\fc3.0\orders"
#Set-Location $homeDir
Set-Location "c:\FC3.0\orders"

$goodsFiles = "c:\FC3.0\orders\auto_import\商品资料.xls", "c:\FC3.0\orders\auto_import\商品资料 .xls", "c:\FC3.0\orders\auto_import\商品资料　.xls", "c:\FC3.0\orders\auto_import\pospal_goods.xls"
foreach ( $targetFileName in $goodsFiles ) {
        Write-Host "looking for " $targetFileName
        if ( Test-Path $targetFileName ) {
            ruby import_pospal_goods.rb $targetFileName
            #Remove-Item -Force -Path $targetFileName
            $today=Get-Date -Format FileDateTime
            $fileBackup="c:\fc3.0\orders\auto_import\imported\pospal_goods-"+$today+".xls"
            Write-Host "moving file to "+$fileBackup
            Move-Item -Force -Path $targetFileName -Destination $fileBackup
        }Else{
            Write-Host "no goods to sync"
        }
}


$fansFiles = "c:\fc3.0\orders\auto_import\wechat_fans.xls"
foreach ( $targetFileName in $fansFiles ) {
        Write-Host "looking for " $targetFileName
        if ( Test-Path $targetFileName ) {
            ruby import_wechat_fans.rb $targetFileName
            #Remove-Item -Force -Path $targetFileName
            $today=Get-Date -Format FileDateTime
            $fileBackup="c:\fc3.0\orders\auto_import\imported\wechat_fans-"+$today+".xls"
            Write-Host "moving file to "+$fileBackup
            Move-Item -Force -Path $targetFileName -Destination $fileBackup
        }Else{
            Write-Host "no fans to sync"
        }
}
