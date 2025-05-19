FROM mcr.microsoft.com/mssql/server:2019-latest

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=${SA_PASSWORD}

USER root
RUN mkdir -p /var/opt/mssql/backup
RUN chown -R mssql /var/opt/mssql

USER mssql
EXPOSE 1433
