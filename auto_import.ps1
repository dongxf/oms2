Set-Executionpolicy remotesigned

#$homeDir = "d:\dongxf\work\oms2"
$homeDir = "c:\FC3.0\orders"

Set-Location $homeDir

#向云标签数据库中导入由银豹系统导出的商品数据资料，导入后将其移动到备份目录
$fileNames = "商品资料","pospal_goods"
foreach ( $targetName in $fileNames ) {
    Get-ChildItem -Path $homeDir"\auto_import\" -Filter *$targetName*.xls* | ForEach-Object {
            $today=Get-Date -Format "yyyyMMdd-HHmm"
            $backup = $homeDir+"\auto_import\goods\"+$today+"-"+$_.Name
            ruby goods_man.rb $_.FullName
            Move-Item -Force -Path $_.FullName -Destination $backup
    }
}