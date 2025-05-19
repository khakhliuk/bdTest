#!/bin/bash

echo "⏳ Чекаємо запуск SQL Server..."

# Чекаємо запуск SQL Server
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "SELECT 1" &> /dev/null

echo "🚀 Відновлюємо базу даних з .bak..."

# Відновлення бази
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "RESTORE FILELISTONLY FROM DISK = N'/var/opt/mssql/backup/YourDb.bak'"


echo "✅ Відновлення завершено."

tail -f /dev/null
