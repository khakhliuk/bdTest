#!/bin/bash

echo "🚀 Пробуємо одразу підключитися..."

# Спроба підключитися до SQL Server
sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "SELECT 1"

echo "❗ Після цього виконується restore (якщо попереднє спрацювало)..."

sqlcmd -S localhost -U SA -P $SA_PASSWORD -Q "RESTORE DATABASE YourDb FROM DISK = N'/var/opt/mssql/backup/YourDb.bak' WITH REPLACE"

tail -f /dev/null
