<?php

$to = "alerts@linuxwork.in";
$from = "no-reply@linuxwork.in";
$min_warn_level = 10; // Set to min load average to send alert

$current_reading = @exec('uptime');
$cpu_utilization = @exec("top -b -n1 | grep 'Cpu(s)' | awk '{print $2 + $4}'");
var_dump($current_reading);var_dump($cpu_utilization);
preg_match("/averages?: ([0-9\.]+),[\s]+([0-9\.]+),[\s]+([0-9\.]+)/", $current_reading, $averages);
$uptime = explode(' up ', $current_reading);
$uptime = explode(',', $uptime[1]); $uptime = $uptime[0].', ' . $uptime[1];
$data = "Server Load Averages $averages[1], $averages[2], $averages[3]\n";
$data .= "<br>Server Uptime $uptime";
$data .= "<br>CPU Utilization Used $cpu_utilization"; 
if ($averages[1] > $min_warn_level )
{ $subject = "Alert : Mumbai Server 1 (35.154.34.232) Load Average is $min_warn_level";
 authSendEmail($from, $namefrom, $to, $subject, $data);
}
echo $data;

/* * * * * * * * * * * * * * SEND EMAIL FUNCTIONS * * * * * * * * * * * * * */

//This will send an email using auth smtp and output a log array
//logArray - connection,

function authSendEmail($from, $namefrom, $to,  $subject, $message)
{
//SMTP + SERVER DETAILS
/* * * * CONFIGURATION START * * * */
$smtpServer = "smtp-host";
$port = "smtp-port";
$timeout = "30";
$username = "smtp-user";
$password = "smtp-password";
$localhost = "smtp-server-ip";
$newLine = "\r\n";
/* * * * CONFIGURATION END * * * * */

//Connect to the host on the specified port
$smtpConnect = fsockopen($smtpServer, $port, $errno, $errstr, $timeout);
$smtpResponse = fgets($smtpConnect, 515);
if(empty($smtpConnect))
{
$output = "Failed to connect: $smtpResponse";
return $output;
}
else
{
$logArray['connection'] = "Connected: $smtpResponse";
}

//Request Auth Login
fputs($smtpConnect,"AUTH LOGIN" . $newLine);
$smtpResponse = fgets($smtpConnect, 515);
$logArray['authrequest'] = "$smtpResponse";

//Send username
fputs($smtpConnect, base64_encode($username) . $newLine);
$smtpResponse = fgets($smtpConnect, 515);
$logArray['authusername'] = "$smtpResponse";

//Send password
fputs($smtpConnect, base64_encode($password) . $newLine);
$smtpResponse = fgets($smtpConnect, 515);
$logArray['authpassword'] = "$smtpResponse";

//Say Hello to SMTP
fputs($smtpConnect, "HELO $localhost" . $newLine);
$smtpResponse = fgets($smtpConnect, 515);
$logArray['heloresponse'] = "$smtpResponse";

//Email From
fputs($smtpConnect, "MAIL FROM: $from" . $newLine);
$smtpResponse = fgets($smtpConnect, 515);
$logArray['mailfromresponse'] = "$smtpResponse";

//Email To
fputs($smtpConnect, "RCPT TO: $to" . $newLine);
$smtpResponse = fgets($smtpConnect, 515);
$logArray['mailtoresponse'] = "$smtpResponse";

//The Email
fputs($smtpConnect, "DATA" . $newLine);
$smtpResponse = fgets($smtpConnect, 515);
$logArray['data1response'] = "$smtpResponse";

//Construct Headers
$headers = "MIME-Version: 1.0" . $newLine;
$headers .= "Content-type: text/html; charset=iso-8859-1" . $newLine;
//$headers .= "To: $nameto <$to>" . $newLine;
//$headers .= "From: $namefrom <$from>" . $newLine;

fputs($smtpConnect, "To: $to\nFrom: $from\nSubject: $subject\n$headers\n\n$message\n.\n");
$smtpResponse = fgets($smtpConnect, 515);
$logArray['data2response'] = "$smtpResponse";

// Say Bye to SMTP
fputs($smtpConnect,"QUIT" . $newLine);
$smtpResponse = fgets($smtpConnect, 515);
$logArray['quitresponse'] = "$smtpResponse";

    // message lines should not exceed 70 characters (PHP rule), so wrap it

}
?>