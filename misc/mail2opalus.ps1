$emailFrom = "pcron@foodtrust.cn"
$emailTo = "opalus460b@foodtrust.cn"
$subject = "TEST"
$boy = "hello, smtp"
$port = 465
$smtpServer = "smtp.exmail.qq.com"
$smtp = new-object Net.Mail.SmtpClient($smtpServer)
$smtp.Send($emailFrom, $emailTo, $subject, $body)


#Net.Mail.SmtpClient mailer = new SmtpClient();
#mailer.Host = "smtp.exmail.qq.com";
#mailer.Port = 465;
#mailer.Credentials = new System.Net.NetworkCredential("pcron@foodtruts.cn", "P123456n");