#This file is used in client side, specifically, mp002, not in pcron server, work with win cron task(incomingFilesHandler.xml)

#print incoming order and move

Set-Location c:\Users\Administrator\Desktop\fc3.0\oms2
Move-Item -Force -Path incoming\*.pdf -Destination staging

Get-ChildItem -Path staging -Filter *-order-*.pdf -Recurse | ForEach-Object {
    #Start-Process -FilePath $_.FullName -Verb Print -Wait #if using -Wait option, acrobat reader will stay there forever, else the file will be deleted before printed
    Start-Process -FilePath $_.fullname -Verb Print -PassThru | %{sleep 12;$_} | kill 
}
#print incoming line file and move
Get-ChildItem -Path staging -Filter *-line-*.pdf -Recurse | ForEach-Object {
    #Start-Process -FilePath $_.FullName -Verb Print -Wait #if using -Wait option, acrobat reader will stay there forever, else the file will be deleted before printed
    Start-Process -FilePath $_.fullname -Verb Print -PassThru | %{sleep 12;$_} | kill 
    #Write-VolumeCache d #try to fix double print bug
}

Move-Item -Force -Path staging\*.pdf -Destination processed\orders