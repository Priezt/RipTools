#!/usr/bin/env python

from pyquery import PyQuery as pq
import sys
import urlparse

if len(sys.argv) != 3:
	raise Exception('need URL and Selector')

url = sys.argv[1]
selector = sys.argv[2]

doc = pq(url)
items = doc(selector)

print items.text()

