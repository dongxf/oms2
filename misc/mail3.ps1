$Username = "pcron@foodtrust.cn";
$Password = "P123456n";
#$path = "C:\FC3.0\pospal_orders\incoming\20190322164129-order-E29CA813.pdf";
$path = "C:\test.txt";

function Send-ToEmail([string]$email, [string]$attachmentpath){

    $message = new-object Net.Mail.MailMessage;
    $message.From = "pcron@foodtrust.cn";
    $message.To.Add($email);
    $message.Subject = "subject text here...";
    $message.Body = "body text here...";
    $attachment = New-Object Net.Mail.Attachment($attachmentpath);
    $message.Attachments.Add($attachment);

    $smtp = new-object Net.Mail.SmtpClient("smtp.exmail.qq.com", 465);
    $smtp.EnableSSL = $true;
    $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
    $smtp.send($message);
    write-host "Mail Sent" ; 
    $attachment.Dispose();
 }
Send-ToEmail  -email "opalus460b@foodtrust.cn" -attachmentpath $path;