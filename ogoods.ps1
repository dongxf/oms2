Set-Location c:\fc3.0\orders

$targetFileName = "c:\fc3.0\orders\goods_exported\商品资料.xls"
if ( Test-Path $targetFileName ) {
	ruby ogoods.rb $targetFileName
    #Remove-Item -Force -Path $targetFileName
    $today=Get-Date -Format FileDateTime
    $fileBackup="c:\fc3.0\orders\goods_exported\商品资料-"+$today+".xls"
    Write-Host $fileBackup
    Move-Item -Force -Path $targetFileName -Destination $fileBackup
}Else{
	#Write-Host "no goods to sync"
}

#避免操作人员留空格的问题
$targetFileName = "c:\fc3.0\orders\goods_exported\商品资料 .xls"
if ( Test-Path $targetFileName ) {
	ruby ogoods.rb $targetFileName
    #Remove-Item -Force -Path $targetFileName
    $today=Get-Date -Format FileDateTime
    $fileBackup="c:\fc3.0\orders\goods_exported\商品资料-"+$today+".xls"
    Write-Host $fileBackup
    Move-Item -Force -Path $targetFileName -Destination $fileBackup
}Else{
	#Write-Host "no goods to sync"
}

$targetFileName = "c:\fc3.0\orders\goods_exported\商品资料　.xls"
if ( Test-Path $targetFileName ) {
	ruby ogoods.rb $targetFileName
    #Remove-Item -Force -Path $targetFileName
    $today=Get-Date -Format FileDateTime
    $fileBackup="c:\fc3.0\orders\goods_exported\商品资料-"+$today+".xls"
    Write-Host $fileBackup
    Move-Item -Force -Path $targetFileName -Destination $fileBackup
}Else{
	#Write-Host "no goods to sync"
}

