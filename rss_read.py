# -*- coding: utf-8 -*-
# vim: set sw=4, ts=4, et
import requests
import feedparser
import sys
import codecs

sys.stdout = codecs.getwriter('utf8')(sys.stdout)
sys.stderr = codecs.getwriter('utf8')(sys.stderr)

if len(sys.argv) != 2:
    print('Usage: rss_read.py url')
    exit(1)

response = requests.get(sys.argv[1])
data = response.content.decode('utf-8', errors='replace');
feed = feedparser.parse(data)

for entry in feed.entries:
    print entry.title

