#!/bin/bash

/opt/mssql/bin/sqlservr &
tail -f /var/opt/mssql/log/errorlog &

echo "⏳ Чекаємо запуску SQL Server..."
sleep 5

# Очікуємо доступність SQL Server перед виконанням sqlcmd
until /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "SELECT 1" &> /dev/null
do
    echo "❌ SQL Server ще не готовий, чекаємо 5 секунд..."
    sleep 5
done

echo "✅ SQL Server готовий! Відновлюємо базу..."

# Відновлення з .bak
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "RESTORE DATABASE [kasinaq] FROM DISK = N'/var/opt/mssql/backup/YourDb.bak' WITH MOVE 'YourDb' TO '/var/opt/mssql/data/YourDb.mdf', MOVE 'YourDb_log' TO '/var/opt/mssql/data/YourDb_log.ldf', REPLACE"
