
from optparse import OptionParser

try:
    from gettext import gettext
except ImportError:
    def gettext(message):
        return message
_ = gettext




# APP_NOM = "dticNewMail.py"

g_sAppCop = "Copyright (C) 2018 Ricardo MONLA <rmonla@gmail.com>"

g_sAppVerNum = "v2.04"
g_sAppVerDesc = """

    v2.01
     * Comienza migración <dticNewMail.py>
    v2.02
     * Agrega Variables Globales.
     * Administra parámetros de linea de comandos.
    v2.03
     * Optimiza OptionParser, usage y version.
    v2.04
     * Se crea fx nm_msj(msj).
     * Optimiza OptionParser, usage y version.
     * Si no tiene los privilegios accede con sudo.
     * Verifica que recibe el parámetro opts.usr.
     * Verifica que opts.usr no exista.


    This is free software; see the source for copying conditions.
    There is NO warranty; not even for MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.

   %s
""" % (g_sAppCop)

g_sUsr    = ""

# print (g_sAppVerDesc)

# duy_ver(){ # <®> Muestra detalle de versión.

#   ### Pendiente:
#   #### Generar logs de descarga.

# reparar bug de parametro --version

#   ${duyAPP} v${duyVER}

#   * #### Se agrega Copyright.
#   * #### Se limpia, ordena y optimiza código.
#   * #### Se mejora ayuda de modo de uso. 
#   * #### Se mejora salidas por pantallas. 
#   * #### Se agrega duy_ver() para mostrar detalles de versión.
#   * #### Se optimiza CAPTURA DE ARGUMENTOS.
#   * #### Se actualiza README.md

# EOF
#   return 0
# }

###########################################################################
# <®> FUNSIONES <®>
###########################################################################

#****************************************************************************
def nm_msj(msj):
    ### <®> Muestra MENSAJE por pantalla. 

    if msj: 
        print _('\n' +msj)

    # -m MENSAJE  Mensaje a mostrar.
    # -u          Muestra uso.
    # -s          Sale del script.
    
    # msj=''
    # uso=0
    # sale=0

    ## Argumentos.
    # while [ "$1" ]; do
    #     case "$1" in
    #     -m)
    #         shift
    #         msj="$1"
    #         ;;
    #     -u)
    #         uso=1
    #         ;;
    #     -s)
    #         sale=1
    #         ;;
    #     esac
    #     shift
    # done

    ## Muestra uso del script.
    # if [ $uso = 1 ]; then
    #     nm_uso
    # fi

    ## Muestra el mensaje.
    # if [ "$msj" != "" ]; then
    #     echo ""
    #     echo "$nmAPP: $msj"
    # fi 

    ## Sale del script.
#     if [ $sale = 1 ]; then
    
#         echo ""
#         echo "###########################################################################"
#         echo ""
#         exit 1
#     else
#         return 0
#     fi
# }



#****************************************************************************

def main(argv):
    global g_sUsr, g_sAppVerNum, g_sAppVerDesc

    usage = "usage: \n  %prog -u USR -a ALIAS"
    version = "\n%prog "+ g_sAppVerNum +"\n" + g_sAppVerDesc 
    
    parse = OptionParser(usage=usage, version=version)
    
    parse.add_option("-u", dest="usr", help = "Nombre de usuario.")
    parse.add_option("-a", dest="alias", help = "Email Alias destino.")
    

    # parse = OptionParser()
    # (opts, args) = parse.parse_args()
    # parse.add_option("-v", "--verbose", dest="verbose", action="store_true", default=False, help = "switch on verbose")
    # parse.add_option("-a", "--autopath", dest="autopath", action="store_true", default=False, help = "switch on autopath")
    # parse.add_option("-w", "--webservice", dest="style", action="store_const", const="WEBSERVICE", help = "connect to webservice")
    # parse.add_option("-c", dest="command_line", help = "command sequence to execute")
    # parse.add_option("-o", dest="opt_line", help = "option line")
    
    
    (opts, args) = parse.parse_args()
 
    # if os.geteuid() != 0 and sys.argv[1] not in ("-h", "--help"):
    def prompt_sudo():
        ret = 0
        if os.geteuid() != 0:
            msg = "[sudo] password for %u:"
            ret = subprocess.check_call("sudo -v -p '%s'" % msg, shell=True)
            # if not ret:
            #     nm_msj("Error: Debe tener privilegios de administrador")

        return ret

    if prompt_sudo() != 0:
        # the user wasn't authenticated as a sudoer, exit?
        nm_msj("OK: Usuario Logeado")
    

    # if os.geteuid() != 0:
    #     try:
    #         prompt_sudo()
    #     except KeyError:
    #         print('User someusr does not exist.')
    #         sys.exit(1)
        

        
        # sys.exit(1)

    if not opts.usr:
        nm_msj("Error: El nombre de usuario [-u] no puede estar en blanco")
        parse.print_usage()
        sys.exit(1)


    def user_exists(username):
        """Check if a user exists"""
        try:
            pwd.getpwnam(username)
            user_exists = True
        except KeyError:
            user_exists = False
        return user_exists 



    if user_exists(opts.usr):
        nm_msj("Error: El usuario <%s> ya existe en el sistema" % opts.usr)
        sys.exit(1)




    # print opts
    # print args
    # g_fVerbose = options.verbose
    # style = options.style


# if __name__ == '__main__':
#     main(sys.argv)


# import os, subprocess


    # def addUserToSystem(self):
    #     """ add the user to SKYRiX via XML-RPC """
    #     try:
    #         # add account to SKYRiX
    #         result = self.__server.account.insert(self.__newMail)
    #     except:
    #         sys.stderr.write("An XML-RPC error occured\n")
    #         return 2

    #     # account.insert returns the inserted user as dictionary if it was
    #     # successful, otherwise a boolean False is returned
    #     if type(result) is DictType:
    #         print "==> created account %s with ID %s" % (result['usr'],
    #                                                      result['id'])
    #         return 0
    #     else:
    #         sys.stderr.write("Failed to create account\n")
    #         return 1

        
        # result = self.getDaemonInfo()
        # if result != 0: return result
