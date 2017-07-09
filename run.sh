#!/bin/bash

/usr/bin/supervisord&
sleep 3
chmod o+r /var/log/*

