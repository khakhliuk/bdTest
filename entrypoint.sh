#!/bin/bash
# Чекаємо запуск SQL Server
echo "⏳ Чекаємо запуск SQL Server..."
until /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -Q "SELECT 1" > /dev/null 2>&1
do
  sleep 5
done

echo "✅ SQL Server запущено, відновлюємо базу..."

# Відновлення бази з бекапу
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -Q "RESTORE DATABASE YourDb FROM DISK = N'/var/opt/mssql/backup/YourDb.bak' WITH REPLACE"

echo "✅ Відновлення завершено. SQL Server запущено."

# Тримати контейнер живим, щоб не завершився
tail -f /dev/null
