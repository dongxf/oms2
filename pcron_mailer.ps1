﻿Set-Location c:\fc3.0\orders

#check for order text file (generated by orderman.rb) and line text file (by brief.rb) , if existed converted it to pdf
Get-ChildItem -Path c:\fc3.0\orders\incoming -Filter *.txt | ForEach-Object {
    $targetFileName = "c:\fc3.0\orders\converted\"+$_.Name
    if ( Test-Path $targetFileName ) {
        Write-Host $targetFileName " already converted, you can open and print it manually to mail it again"
    }Else{
        Start-Process -FilePath $_.FullName -Verb Print -Wait
    }
    Move-Item -Force -Path $_.FullName -Destination c:\fc3.0\orders\converted
}

#check for order pdf file, if existed, mail to opalus460b
Get-ChildItem -Path c:\fc3.0\orders\incoming -Filter *-order-*.pdf | ForEach-Object {
    $subject = "new pospal order "+$_.Name
    .\mailsend -smtp smtp.exmail.qq.com -port 465 -ssl -auth -user pcron@foodtrust.cn -pass P123456n  -f pcron@foodtrust.cn -t opalus460b@foodtrust.cn -sub $subject -M "new order file" -attach $_.FullName
    Move-Item -Force -Path $_.FullName -Destination C:\fc3.0\orders\mailed
}

#check for line file, if existed, mail to opalus460b
Get-ChildItem -Path c:\fc3.0\orders\incoming -Filter *-line-*.pdf | ForEach-Object {
    $subject = "new line file "+$_.Name
    .\mailsend -smtp smtp.exmail.qq.com -port 465 -ssl -auth -user pcron@foodtrust.cn -pass P123456n  -f pcron@foodtrust.cn -t opalus460b@foodtrust.cn -cc huangc@foodtrust.cn -sub $subject -M "new line file" -attach $_.FullName
    Move-Item -Force -Path $_.FullName -Destination C:\fc3.0\orders\mailed
}

#check for express data, if existed, mail to opalus460b
Get-ChildItem -Path c:\fc3.0\orders\incoming -Filter *.xls | ForEach-Object {
    $subject = "new express data "+$_.Name
    .\mailsend -smtp smtp.exmail.qq.com -port 465 -ssl -auth -user pcron@foodtrust.cn -pass P123456n  -f pcron@foodtrust.cn -t opalus460b@foodtrust.cn -cc huangc@foodtrust.cn -sub $subject -M "new express data" -attach $_.FullName
    Move-Item -Force -Path $_.FullName -Destination C:\fc3.0\orders\mailed
}

#check for express label, if existed, mail to opalus460b
Get-ChildItem -Path c:\fc3.0\orders\incoming -Filter 三联单-*.pdf | ForEach-Object {
    $subject = "new express label "+$_.Name
    .\mailsend -smtp smtp.exmail.qq.com -port 465 -ssl -auth -user pcron@foodtrust.cn -pass P123456n  -f pcron@foodtrust.cn -t opalus460b@foodtrust.cn -sub $subject -M "new express label" -attach $_.FullName
    Move-Item -Force -Path $_.FullName -Destination C:\fc3.0\orders\mailed
}
