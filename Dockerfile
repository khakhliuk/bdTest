FROM mcr.microsoft.com/mssql/server:2019-latest

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=kG2BaS25Lf216Gsbaw

WORKDIR /var/opt/mssql
COPY ./YourDb.bak /var/opt/mssql/backup/YourDb.bak
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
