# ReminderSVC
MySQL and Powershell program to send text/email reminders.

<b>Requirements:</b>

MySQL instance

SMTP account/server

MySQL Connector - https://dev.mysql.com/downloads/connector/net/

Powershell

<b>MySQL setup:</b>

Database name: reminder_svc

Table name: reminders

-Table Columns:

--EntryID (int)

--Recipient (varchar)

--Message (varchar)


Program allows you to do the following:

<b>1. Add reminder.</b>
- Enters a new reminders into the reminders table. It will prompt you for Recipient and Message then generate a random EntryID.

<b>2. Remove reminder.</b>
- Will show you existing reminders and prompt you with which one to remove by entering the EntryID

<b>3. Show reminders.</b>
- Will show you existing reminders.

<b>4. Force send reminder.</b>
- Shows you existing reminders and prompts for which one you want to send. Will then prompt you for your SMTP server credentials.

<b>5. Exit.</b>
- Exits program.

You will possibly need to make the following changes:

Line 2 - MySQL Connector path

Line 4 - Update your connection string with your MySQL instance details

Line 129 - The FROM address and DISPLAYNAME

Line 130 - SMTPSERVER, PORT, SUBJECT, SSL
