#!/bin/sh


sed -i "s#UUID#$UUID#g;" /etc/sbox/config.json


/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
