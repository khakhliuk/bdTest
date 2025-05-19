FROM mcr.microsoft.com/mssql/server:2019-latest

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=YourStrong!Passw0rd

# Створюємо папку для бекапів
RUN mkdir -p /var/opt/mssql/backup

# Копіюємо базу і скрипт
COPY ./YourDb.bak /var/opt/mssql/backup/YourDb.bak
COPY ./entrypoint.sh /entrypoint.sh

# Встановлюємо робочу директорію
WORKDIR /var/opt/mssql

# Запускаємо скрипт через bash без chmod
CMD ["/bin/bash", "/entrypoint.sh"]
