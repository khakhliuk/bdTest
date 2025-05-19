FROM mcr.microsoft.com/mssql/server:2019-latest

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=kG2BaS25Lf216Gsbaw

USER root

# Копіюємо беккап і даємо права користувачу mssql
COPY ./YourDb.bak /var/opt/mssql/backup/YourDb.bak
RUN chown mssql:mssql /var/opt/mssql/backup/YourDb.bak

# Копіюємо скрипт і даємо права
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && chown mssql:mssql /entrypoint.sh

USER mssql

CMD ["/bin/bash", "/entrypoint.sh"]
