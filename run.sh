#!/bin/bash

touch /var/log/maillog
touch /var/log/messages
chmod o+r /var/log/*

postmap /etc/postfix/user/recipient_access
postmap /etc/postfix/user/relay_domains
postmap /etc/postfix/user/sender_access

/usr/bin/supervisord
