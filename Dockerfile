FROM alpine:3.6
RUN apk update
RUN apk add --no-cache --update postfix ca-certificates supervisor rsyslog bash

COPY /etc/supervisord.conf /etc/

COPY /etc/postfix/* /etc/postfix/
RUN touch /etc/postfix/recipient_access  /etc/postfix/recipient_access.regexp  /etc/postfix/relay_domains  /etc/postfix/sender_access
RUN newaliases
RUN postmap /etc/postfix/virtual
RUN postmap /etc/postfix/recipient_access
RUN postmap /etc/postfix/relay_domains
RUN postmap /etc/postfix/sender_access

COPY run.sh .
RUN chmod +x run.sh

EXPOSE 25

VOLUME /var/log
VOLUME /var/spool/mail

CMD ["./run.sh"]
