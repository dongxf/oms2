Set-Location d:\fc3.0\orders

Get-ChildItem -Path d:\fc3.0\orders\incoming -Filter *.pdf -Recurse | ForEach-Object {
    #Start-Process -FilePath $_.FullName -Verb Print #if using -Wait option, acrobat reader will stay there forever, else the file will be deleted before printed
    Start-Process -FilePath $_.fullname -Verb Print -PassThru | %{sleep 10;$_} | kill 
    Move-Item -Force -Path $_.FullName -Destination d:\fc3.0\orders\printed
}
