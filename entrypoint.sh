#!/bin/bash

echo "⏳ Чекаємо запуск SQL Server..."

# Чекаємо запуск SQL Server
for i in {1..30}; do
    /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "SELECT 1" &> /dev/null
    if [ $? -eq 0 ]; then
        echo "✅ SQL Server запущено!"
        break
    else
        echo "❌ SQL Server ще не готовий, чекаємо 5 секунд..."
        sleep 5
    fi
done

echo "🚀 Відновлюємо базу даних з .bak..."

# Відновлення бази
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "RESTORE DATABASE [YourDb] FROM DISK = N'/var/opt/mssql/backup/YourDb.bak' WITH REPLACE, MOVE 'YourDb' TO '/var/opt/mssql/data/YourDb.mdf', MOVE 'YourDb_log' TO '/var/opt/mssql/data/YourDb_log.ldf'"

echo "✅ Відновлення завершено."

tail -f /dev/null
