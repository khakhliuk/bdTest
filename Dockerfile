FROM mcr.microsoft.com/mssql/server:2019-latest

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=kG2BaS25Lf216Gsbaw

# Копіюємо файли
COPY ./YourDb.bak /var/opt/mssql/backup/YourDb.bak
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

USER mssql

CMD ["/bin/bash", "/entrypoint.sh"]
