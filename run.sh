#!/bin/bash

touch /var/log/maillog
touch /var/log/messages
chmod o+r /var/log/*
/usr/bin/supervisord
