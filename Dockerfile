FROM alpine:3.6
RUN apk update
RUN apk add --no-cache --update postfix ca-certificates supervisor rsyslog bash

COPY /etc/supervisord.conf /etc/

COPY /etc/postfix/* /etc/postfix/
RUN postmap /etc/postfix/virtual
RUN newaliases

COPY run.sh .
RUN chmod +x run.sh

EXPOSE 25

VOLUME /var/log
VOLUME /var/spool/mail

CMD ["./run.sh"]
