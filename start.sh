#!/bin/bash

echo "Starting cron"
/usr/local/bin/go-crond --allow-unprivileged /opt/rss2gmail/cron.txt > /app-data/rss2email.log.cron &
echo "Starting rss2email feed check"
python /opt/rss2gmail/ren-rss2gmail.py /app-data
# Send logs to stdout
echo "Logs:"
tail -f /app-data/ren-rss2gmail.log