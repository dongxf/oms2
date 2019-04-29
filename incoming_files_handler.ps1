#This file is used in client side, not in pcron server, work with win cron task(incomingFilesHandler.xml)

Set-Location d:\fc3.0\orders

#print incoming order and move
Get-ChildItem -Path d:\fc3.0\orders\incoming -Filter *-order-*.pdf -Recurse | ForEach-Object {
    #Start-Process -FilePath $_.FullName -Verb Print #if using -Wait option, acrobat reader will stay there forever, else the file will be deleted before printed
    Start-Process -FilePath $_.fullname -Verb Print -PassThru | %{sleep 12;$_} | kill 
    Move-Item -Force -Path $_.FullName -Destination d:\fc3.0\orders\processed\orders
    Write-VolumeCache d #try to fix double print bug
}

#print incoming line file and move
Get-ChildItem -Path d:\fc3.0\orders\incoming -Filter *-line-*.pdf -Recurse | ForEach-Object {
    #Start-Process -FilePath $_.FullName -Verb Print #if using -Wait option, acrobat reader will stay there forever, else the file will be deleted before printed
    Start-Process -FilePath $_.fullname -Verb Print -PassThru | %{sleep 12;$_} | kill 
    Move-Item -Force -Path $_.FullName -Destination d:\fc3.0\orders\processed\lines
    Write-VolumeCache d #try to fix double print bug
}

#print incoming express label and move
Get-ChildItem -Path d:\fc3.0\orders\incoming -Filter 三联单-*.pdf -Recurse | ForEach-Object {
    #Start-Process -FilePath $_.FullName -Verb Print #if using -Wait option, acrobat reader will stay there forever, else the file will be deleted before printed
    Start-Process -FilePath $_.fullname -Verb Print -PassThru | %{sleep 12;$_} | kill 
    Move-Item -Force -Path $_.FullName -Destination d:\fc3.0\orders\processed\express-labels
    Write-VolumeCache d #try to fix double print bug
}


#move incoming express data can be imported into express system, then print labels from express system
Get-ChildItem -Path d:\fc3.0\orders\incoming -Filter *-CND-*.xls -Recurse | ForEach-Object {
    Move-Item -Force -Path $_.FullName -Destination d:\fc3.0\orders\processed\express-data
    Write-VolumeCache d #try to fix double print bug
}
