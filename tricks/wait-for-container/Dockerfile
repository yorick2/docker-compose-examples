FROM nginx:1.20.1

WORKDIR /var/www/html

RUN apt-get update \
    && apt-get install -y default-mysql-client

COPY wait-for-file.sh /usr/local/bin/wait-for-file.sh
COPY wait-for-mysql.sh /usr/local/bin/wait-for-mysql.sh
COPY start-container /usr/local/bin/start-container

RUN chmod +x /usr/local/bin/wait-for-file.sh \
    && chmod +x /usr/local/bin/wait-for-mysql.sh \
    && chmod +x /usr/local/bin/start-container

EXPOSE 9000

ENTRYPOINT ["start-container","nginx", "-g", "daemon off;"]
