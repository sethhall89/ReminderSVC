#region ConnectToDatabase
[void][System.Reflection.Assembly]::LoadFrom("C:\Program Files (x86)\MySQL\MySQL Connector Net 8.0.23\Assemblies\v4.5.2\MySql.Data.dll")
$dbconnection = New-Object Mysql.Data.MySqlClient.MySqlConnection
$dbconnection.connectionstring = "server=192.168.1.79;user id=psdev2;password=Abcd1234!;database=reminder_svc;"
#endregion


#region MakeSelection
Do {
$selection = ''
$valid_options = @('1','2','3','4','5')
while ([string]::IsNullOrEmpty($selection))
{
Write-Host "======================="
Write-Host "What do you want to do?"
$selection = Read-Host `
"1. Add reminder.
2. Remove reminder.
3. Show reminders.
4. Force send reminder.
5. Exit.
=======================
"
if ($selection -notin $valid_options)
{
Write-Warning "Not a valid option. Try again"
$selection = ''
pause
}

switch ($selection)
{
1 
{
$dbconnection.open()
$db_insertcommand = New-Object MySql.Data.MySqlClient.MySqlCommand
$db_insertcommand.Connection = $dbconnection
$entryid = Get-Random -Minimum 100 -Maximum 999
$recipient = Read-Host "Enter the recipient"
$message = Read-Host "Enter the message"
$db_insertcommand.CommandText = "INSERT INTO reminders (EntryID, Recipient, Message) `
VALUES ('$entryid', '$recipient', '$message')"

$db_insertcommand.ExecuteNonQuery()
$dbconnection.close()
Write-Host `
"
=======================
Record added:
$entryid | $recipient | $message"

break
}

2
{
$dbconnection.open()
$dbcommand = New-Object MySql.Data.MySqlClient.MySqlCommand
$dbcommand.Connection = $dbconnection
$dbcommand.CommandText = "SELECT EntryID, Recipient, Message FROM reminders;"
$current_entries = $dbcommand.ExecuteReader()
while ($current_entries.Read()){$current_entries.GetString(0) + " | " + $current_entries.GetString(1) + " | " + $current_entries.GetString(2)}
$dbconnection.close()
Write-Host `
"
=======================


"
$entryid = Read-Host "Enter the EntryID for the reminder you want to delete"
$dbconnection.open()
$db_removecommand = New-Object MySql.Data.MySqlClient.MySqlCommand
$db_removecommand.Connection = $dbconnection
$db_removecommand.CommandText = "DELETE FROM reminders WHERE EntryID='$entryid'"

$db_removecommand.ExecuteNonQuery()
$dbconnection.close()
Write-Host `
"
=======================


"
break
}

3
{
$dbconnection.open()
$dbcommand = New-Object MySql.Data.MySqlClient.MySqlCommand
$dbcommand.Connection = $dbconnection
$dbcommand.CommandText = "SELECT EntryID, Recipient, Message FROM reminders;"
$current_entries = $dbcommand.ExecuteReader()
Write-host "Current Reminders:"
while ($current_entries.Read()){$current_entries.GetString(0) + " | " + $current_entries.GetString(1) + " | " + $current_entries.GetString(2)}
$dbconnection.close()
Write-Host `
"
=======================


"
}

4
{
$dbconnection.open()

$db_showcommand = New-Object MySql.Data.MySqlClient.MySqlCommand
$db_showcommand.Connection = $dbconnection
$db_showcommand.CommandText = "SELECT EntryID, Recipient, Message FROM reminders;"
$current_entries = $db_showcommand.ExecuteReader()
while ($current_entries.Read()){$current_entries.GetString(0) + " | " + $current_entries.GetString(1) + " | " + $current_entries.GetString(2)}
$dbconnection.close()
$dbconnection.open()
$dbcommand = New-Object MySql.Data.MySqlClient.MySqlCommand
$dbcommand.Connection = $dbconnection

$opt = Read-Host "Whats the EntryID you want to send?"
$dbcommand.CommandText = "SELECT EntryID, Recipient, Message FROM reminders WHERE EntryID=$opt"

$dbdataadapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter
$dbdataadapter.SelectCommand = $dbcommand

$dbdata = New-Object System.Data.DataSet
$numberofdatasets = $dbdataadapter.Fill($dbdata)

$creds = Get-Credential
$from = New-Object System.Net.Mail.MailAddress("reminders@mcsa365lab.com","SethHall Reminder Service")
Send-MailMessage -From $from -SmtpServer smtp.office365.com -Credential $creds -UseSsl -To $dbdata.Tables[0].Rows[0].Recipient -Body $dbdata.Tables[0].Rows[0].Message -Port 587 -Subject "Reminder Service"
$dbconnection.close()
Write-Host `
"
=======================


"
break
}

5
{
Write-Host "Exiting" -ForegroundColor Yellow
break
}
default 
{
"Not a valid option. Try again."
Write-Host `
"
=======================


"
}
}
}
}until($selection -eq "5")
#endregion