import pwd
def finduser(user):
	if pwd.getpwnam(user):
		print user, " SI existe"
	else:
		print user, " NO existe"

finduser('rmonla')

import pwd
def finduser(user):
	try:
		pwd.getpwnam(user)
		print user, " SI existe"
	except:
		print user, " NO existe"

finduser('pepe')
