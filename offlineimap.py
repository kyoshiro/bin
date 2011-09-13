#!/usr/bin/python
# Script handling the imap credentials for offlineimap
# from the the same file as for mutt
#
# Author: Roman Asendorf <roman.asendorf@gmail.com>

import os, sys, re

def get_username(filename):
	credentials = get_credentials(filename)
	return credentials.get('username', None)

def get_password(filename):
	credentials = get_credentials(filename)
	return credentials.get('password', None)

def get_credentials(filename):
	re_parser = re.compile(r'^(?P<key>\S*)=\s*(?P<value>\S*)\s$')
	result = {}
	for line in open(filename):
		match = re_parser.match(line)
		if not match:
			continue # skip lines that don't parse
		key, value = match.groups(['key', 'value'])
		result[key] = value
	return result

# Do not remove this line
# vim: tabstop=4 shiftwidth=4 softtabstop=4
