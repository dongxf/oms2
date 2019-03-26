#https://www.techrepublic.com/blog/windows-and-office/send-an-email-with-an-attachment-using-powershell/
#https://www.makeuseof.com/tag/send-email-windows-powershell/

$From = "FOODTRUST PCRON<pcron@foodtrust.cn>"
$To = "opalus460b@foodtrust.cn"
$Attachment = "C:\FC3.0\pospal_orders\incoming\20190322071222-order-6216EDF1.pdf"
$Subject = "new pospal order received"
$Body = "new pospal order received"
$SMTPServer = "163.177.72.143"
$SMTPPort = 465
#Send-MailMessage -From $From -to $To -Subject $Subject -Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl -Credential (Get-Credential) -Attachments $Attachment –DeliveryNotificationOption OnSuccess

#https://community.spiceworks.com/topic/2123933-powershell-send-mailmessage-credential-syntax
#https://social.msdn.microsoft.com/Forums/azure/en-US/8cf62acc-6fc7-4118-be1b-5bbbbe6a9e93/sendmailmessage-unable-to-read-data-from-the-transport-connection-netioconnectionclosed

$Username = 'pcron@foodtrust.cn'
#$Password = 'P123456n'
#https://stackoverflow.com/questions/41548059/new-object-cannot-find-an-overload-for-pscredential-and-the-argument-count
[string][ValidateNotNullOrEmpty()]$Passwd = "P123456n"
$MyPasswd = ConvertTo-SecureString -String $Passwd -AsPlainText -Force
$MyCreds = New-Object System.Management.Automation.PSCredential $Username, $MyPasswd
Send-MailMessage -From $From -to $To -Subject $Subject -Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl -Credential $MyCreds -Attachments $Attachment –DeliveryNotificationOption OnSuccess
#Send-MailMessage -From $From -to $To -Subject $Subject -Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl -Credential (Get-Credential) -Attachments $Attachment –DeliveryNotificationOption OnSuccess