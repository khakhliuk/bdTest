#!/bin/bash

echo "⏳ Чекаємо запуск SQL Server..."

# Чекаємо запуск SQL Server
echo "🪵 Дивимось логи..."
cat /var/opt/mssql/log/errorlog

sleep infinity

