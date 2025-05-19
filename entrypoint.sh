#!/bin/bash

/opt/mssql/bin/sqlservr &

# Чекаємо запуск SQL Server (приблизно 15 секунд)
sleep 20

# Відновлення бази
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q "RESTORE DATABASE [kasinaq] FROM DISK = N'/var/opt/mssql/backup/YourDb.bak' WITH MOVE 'YourDb' TO '/var/opt/mssql/data/YourDb.mdf', MOVE 'YourDb_log' TO '/var/opt/mssql/data/YourDb_log.ldf', REPLACE"
