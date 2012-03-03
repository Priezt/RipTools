#!/usr/bin/env python

from pyquery import PyQuery as pq
import sys
import urlparse

if len(sys.argv) != 2:
	raise Exception('need URL')

url = sys.argv[1]

doc = pq(url)
items = doc("head title")

print items.text().encode('utf-8')
