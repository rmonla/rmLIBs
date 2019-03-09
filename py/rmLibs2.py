#!/usr/bin/env python

# adds users with the given attributes to the OGo system

import getpass, string, sys, xmlrpclib
from types import *

class AddUserTool:

    def __init__(self):
        """ initialization """
        self.__newUser = {}
        self.__server  = None

    def getUserInput(self, _description, _pwdInput=0):
        """ get information from the user """
        if not _pwdInput:
            # get normal input
            response = raw_input("%-20s" % _description)
        else:
            # get password input
            response = getpass.getpass("%-20s" % _description)

        return response

    def getDaemonInfo(self):
        """ get xml-rpc daemon information, setup daemon connection """
        self.__url = self.getUserInput('XML-RPC Daemon URL:',0)
        self.__login = self.getUserInput('Username:',0)
        self.__pwd = self.getUserInput('Password:',1)

        try:
            # try to init xml-rpc server proxy with the given information
            # (you need the patched xmlrpclib.py for this)
            self.__server = xmlrpclib.ServerProxy(self.__url,
                                                  login=self.__login,
                                                  password=self.__pwd)
        except TypeError,e:
            # seems you are using a xmlrpclib.py without basic authentication
            # support - see the error message how to get the right one
            sys.stderr.write("ERROR: You are probably using the wrong version"
                             "of xmlrpclib\nGet the right version at:\n")
            sys.stderr.write("http://developer.skyrix.com/02_skyrix/xmlrpc/"
                             "xmlrpclib.py\n")
            return 2
        except IOError,e:
            # these errors are caused by specifying a wrong XML-RPC protocol
            # (XML-RPC only supports HTTP)
            sys.stderr.write("ERROR: %s\n" % e)
            return 3

        return 0
        
    def collectUserInfo(self):
        """ collect all infos we need """
        print "-- Adding new user"
        self.__newUser['login'] = self.getUserInput('Enter login:',0)
        self.__newUser['password'] = self.getUserInput('Password:',1)
        self.__newUser['name'] = self.getUserInput('Lastname:',0)
        self.__newUser['firstname'] = self.getUserInput('Firstname:',0)

    def addUserToSystem(self):
        """ add the user to SKYRiX via XML-RPC """
        try:
            # add account to SKYRiX
            result = self.__server.account.insert(self.__newUser)
        except:
            sys.stderr.write("An XML-RPC error occured\n")
            return 2

        # account.insert returns the inserted user as dictionary if it was
        # successful, otherwise a boolean False is returned
        if type(result) is DictType:
            print "==> created account %s with ID %s" % (result['login'],
                                                         result['id'])
            return 0
        else:
            sys.stderr.write("Failed to create account\n")
            return 1
        
    def run(self):
        """ run """
        result = self.getDaemonInfo()
        if result != 0: return result

        another = 'y'

        while another == 'y':
            self.collectUserInfo()
            ok = self.getUserInput("Create user? [Y/n]:",0)
            if not ok:
                ok = "y"

            if string.lower(ok) == "y": 
                result = self.addUserToSystem()
                if result != 0: return result
                
            another = self.getUserInput("Add another user? [y/N]:",0)
            if not another:
                another = "n"

        return 0

if __name__ == "__main__":
  tool = AddUserTool()

  try:
      returnCode = tool.run()
  except KeyboardInterrupt:
      sys.stderr.write("Program cancelled by user\n")
      returnCode = 2

  sys.exit(returnCode)
