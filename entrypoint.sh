#!/bin/bash

echo "⏳ Чекаємо запуск SQL Server..."
sleep 20

# Відновлення бази з .bak (підстав правильні імена logical files)
# Для прикладу логічні імена 'YourDb' і 'YourDb_log' — перевір у своєму .bak файлі!
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "RESTORE DATABASE [kasinaq] FROM DISK = N'/var/opt/mssql/backup/YourDb.bak' WITH MOVE 'YourDb' TO '/var/opt/mssql/data/kasinaq.mdf', REPLACE"

echo "✅ Відновлення завершено. SQL Server запущено."
tail -f /var/opt/mssql/log/errorlog
