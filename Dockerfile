FROM mcr.microsoft.com/mssql/server:2019-latest

USER root

# Встановлюємо sqlcmd та залежності
RUN apt-get update && \
    ACCEPT_EULA=Y apt-get install -y curl apt-transport-https gnupg && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev && \
    ln -sfn /opt/mssql-tools/bin/sqlcmd /usr/bin/sqlcmd && \
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

ENV PATH="${PATH}:/opt/mssql-tools/bin"

USER mssql

# Копіюємо файли
COPY ./YourDb.bak /var/opt/mssql/backup/YourDb.bak
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
