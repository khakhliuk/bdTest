#!/bin/bash

# Запускаємо SQL Server у фоновому режимі
/opt/mssql/bin/sqlservr &

echo "⏳ Чекаємо запуск SQL Server..."
sleep 15  # даємо йому стартонути

# Відновлення з .bak
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "
RESTORE DATABASE [kasinaq]
FROM DISK = N'/var/opt/mssql/backup/YourDb.bak'
WITH MOVE 'YourDb' TO '/var/opt/mssql/data/kasinaq.mdf',
     MOVE 'YourDb_log' TO '/var/opt/mssql/data/kasinaq_log.ldf',
     REPLACE;
"

echo "✅ Відновлення завершено. SQL Server запущено."

# Тримаємо процес живим
tail -f /var/opt/mssql/log/errorlog
