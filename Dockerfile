FROM mcr.microsoft.com/mssql/server:2019-latest

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=${SA_PASSWORD}

# Додаткові пакети для sqlcmd
USER root
RUN apt-get update && apt-get install -y curl gnupg \
 && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
 && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
 && apt-get update && ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev \
 && apt-get clean

ENV PATH="$PATH:/opt/mssql-tools/bin"

COPY ./YourDb.bak /var/opt/mssql/backup/YourDb.bak

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN chown -R mssql /var/opt/mssql /entrypoint.sh

USER mssql

CMD ["/bin/bash", "/entrypoint.sh"]
