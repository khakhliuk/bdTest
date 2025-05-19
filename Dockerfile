FROM mcr.microsoft.com/mssql/server:2019-latest

USER root

# Встановлюємо sqlcmd
RUN apt-get update && \
    ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev && \
    ln -sfn /opt/mssql-tools/bin/* /usr/local/bin

# Копіюємо .bak
COPY ./YourDb.bak /var/opt/mssql/backup/YourDb.bak

# Копіюємо entrypoint
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER mssql

CMD ["/bin/bash", "/entrypoint.sh"]
