#!/bin/bash

# Старт SQL Server у фоні
/opt/mssql/bin/sqlservr &

echo "⏳ Очікуємо старт SQL Server..."
# Чекаємо доки sqlcmd може підключитись
until /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "SELECT 1" > /dev/null 2>&1; do
    echo "❌ SQL Server ще не готовий, чекаємо 5 секунд..."
    sleep 5
done

echo "✅ SQL Server запущено! Імпортуємо базу..."

# Якщо є .bak — імпортуємо
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "
RESTORE DATABASE [kasinaq]
FROM DISK = N'/var/opt/mssql/backup/YourDb.bak'
WITH MOVE 'YourDb' TO '/var/opt/mssql/data/kasinaq.mdf',
     MOVE 'YourDb_log' TO '/var/opt/mssql/data/kasinaq_log.ldf',
     REPLACE;
"

# Або інший скрипт, якщо потрібно
# /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -i init.sql

wait
