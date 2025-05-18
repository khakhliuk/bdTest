#!/bin/bash
/opt/mssql/bin/sqlservr &

# Чекаємо запуск SQL Server
sleep 20

# Відновлення бази з .bak
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P kG2BaS25Lf216Gsbaw -Q \
"RESTORE DATABASE [YourDb] FROM DISK = N'/var/opt/mssql/backup/YourDb.bak' WITH MOVE 'YourDb' TO '/var/opt/mssql/data/YourDb.mdf', MOVE 'YourDb_log' TO '/var/opt/mssql/data/YourDb_log.ldf'"

wait
