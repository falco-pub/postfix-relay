FROM alpine:3.6
RUN apk update
RUN apk add --no-cache --update postfix ca-certificates supervisor rsyslog bash

RUN mkdir -p /opt
RUN mkdir -p /var/log/supervisor

COPY /etc/supervisord.conf /etc/

COPY /etc/postfix/* /etc/postfix/
RUN postmap /etc/postfix/virtual
RUN newaliases


EXPOSE 25

VOLUME /var/log
VOLUME /var/spool/mail

CMD ["/usr/bin/supervisord"]
