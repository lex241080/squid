#!/bin/sh

usermod --non-unique --uid "$UID" squid 
groupmod --non-unique --gid "$GID" squid

if [ ! -f /etc/squid/cachemgr.conf ]; then
    cp /usr/local/etc/cachemgr.conf /etc/squid > /dev/null 2>&1
fi

if [ ! -f /etc/squid/cachemgr.conf.default ]; then
    cp /usr/local/etc/cachemgr.conf.default /etc/squid > /dev/null 2>&1
fi

if [ ! -f /etc/squid/errorpage.css ]; then
    cp /usr/local/etc/errorpage.css /etc/squid > /dev/null 2>&1
fi

if [ ! -f /etc/squid/errorpage.css.default ]; then
    cp /usr/local/etc/errorpage.css.default /etc/squid > /dev/null 2>&1
fi

if [ ! -f /etc/squid/mime.conf ]; then
    cp /usr/local/etc/mime.conf /etc/squid > /dev/null 2>&1
fi

if [ ! -f /etc/squid/mime.conf.default ]; then
    cp /usr/local/etc/mime.conf.default /etc/squid > /dev/null 2>&1
fi

if [ ! -f /etc/squid/squid.conf ]; then
    cp /usr/local/etc/squid.conf /etc/squid > /dev/null 2>&1
fi

if [ ! -f /etc/squid/squid.conf.default ]; then
    cp /usr/local/etc/squid.conf.default /etc/squid > /dev/null 2>&1
fi

if [ ! -f /etc/squid/squid.conf.documented ]; then
    cp /usr/local/etc/squid.conf.documented /etc/squid > /dev/null 2>&1
fi

if [ ! -e /var/lib/ssl_db ]; then
    /usr/lib/squid/security_file_certgen -c -s /var/lib/ssl_db -M 16MB
    chown -R squid:squid /var/lib/ssl_db
fi

chown -R "${UID}:${GID}" /var/log/squid

tail -F /var/log/squid/access.log 2>/dev/null &
tail -F /var/log/squid/error.log 2>/dev/null &

/usr/sbin/squid -Nz
"$@"
