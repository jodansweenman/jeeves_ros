#!/usr/bin/python
"""
CherryPy WebServer starter.
"""

__author__    = 'Jovan Brakus <jovan@brakus.rs>'
__contact__   = 'jovan@brakus.rs'
__date__      = '31 May 2012'

import logging
import sys

import rospy

#Set logging handlers for the first time
import logconfig

from configserver.web import ConfigServer

log = logging.getLogger(__name__)

def main():
	try:
		rospy.init_node('jeeves_2d_nav_web_ui')
		webConfigServer = ConfigServer()
		webConfigServer.start()
		return 0
	except:
		# Dump callstack to log and exit with -1
		log.exception('Unexpected exception occured.') 
		return -1
	
if __name__ == '__main__':
      sys.exit(main())

