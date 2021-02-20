# ReminderSVC
MySQL and Powershell program to send text/email reminders.

Requirements:
MySQL instance
SMTP account/server
MySQL Connector - https://dev.mysql.com/downloads/connector/net/
Powershell

MySQL setup:
Database name: reminder_svc
Table name: reminders
-Table Columns:
--EntryID (int)
--Recipient (varchar)
--Message (varchar)

Program allows you to do the following:
1. Add reminder.
- Enters a new reminders into the reminders table. It will prompt you for Recipient and Message then generate a random EntryID.

2. Remove reminder.
- Will show you existing reminders and prompt you with which one to remove by entering the EntryID

3. Show reminders.
- Will show you existing reminders.

4. Force send reminder.
- Shows you existing reminders and prompts for which one you want to send. Will then prompt you for your SMTP server credentials.

5. Exit.
- Exits program.

You will possibly need to make the following changes:
Line 2 - MySQL Connector path
Line 4 - Update your connection string with your MySQL instance details
Line 129 - The FROM address and DISPLAYNAME
Line 130 - SMTPSERVER, PORT, SUBJECT, SSL
