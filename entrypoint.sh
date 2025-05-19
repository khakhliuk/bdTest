#!/bin/bash

echo "⏳ Чекаємо запуск SQL Server..."
/opt/mssql/bin/sqlservr &

# Чекаємо поки SQL Server буде готовий
echo "⏳ Очікуємо готовності..."
sleep 20

# Підключення та відновлення бази
echo "🚀 Відновлюємо базу з .bak..."
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "
RESTORE DATABASE [kasinaq]
FROM DISK = '/var/opt/mssql/backup/YourDb.bak'
WITH MOVE 'YourDb' TO '/var/opt/mssql/data/kasinaq.mdf',
     MOVE 'YourDb_log' TO '/var/opt/mssql/data/kasinaq_log.ldf',
     REPLACE;
"

wait
