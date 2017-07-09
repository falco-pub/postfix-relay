FROM alpine:3.6
RUN apk update
RUN apk add --no-cache --update postfix ca-certificates supervisor rsyslog bash

COPY /etc/supervisord.conf /etc/

COPY /etc/postfix/* /etc/postfix/
RUN mkdir /etc/postfix/user
RUN touch /etc/postfix/user/recipient_access  /etc/postfix/user/recipient_access.regexp  /etc/postfix/user/relay_domains  /etc/postfix/user/sender_access
RUN newaliases
RUN postmap /etc/postfix/user/recipient_access
RUN postmap /etc/postfix/user/relay_domains
RUN postmap /etc/postfix/user/sender_access

COPY run.sh .
RUN chmod +x run.sh

EXPOSE 25

VOLUME /var/log
VOLUME /etc/postfix/user

CMD ["./run.sh"]
