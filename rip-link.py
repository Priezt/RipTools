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

def print_href(idx, node):
	this = pq(node)
	href = this.attr('href')
	print urlparse.urljoin(url, href)

items.each(print_href)

