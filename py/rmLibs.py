
###########################################################################
# <®> OptionParser
###########################################################################

#****************************************************************************
def main():
    usage = "usage: %prog list\n" \
            "       %prog cat URI"
    version = "%prog 1.0.2\n" \
              "Copyright (c) 2013 Vitor Baptista.\n" \
              "This is free software; see the source for copying conditions.\n" \
              "There is NO warranty; not even for MERCHANTABILITY or\n" \
              "FITNESS FOR A PARTICULAR PURPOSE."
    parser = OptionParser(usage=usage,
                          version=version)
    (options, args) = parser.parse_args()



if os.geteuid() != 0 and sys.argv[1] not in ("-h", "--help"):
    print(_("Error: must run as root"))
    sys.exit(1)

#****************************************************************************
usage = "usage: %prog [options] repository"
parser = OptionParser(usage=usage)
parser.add_option("-y", "--yes", dest="forceYes", action="store_true",
    help="force yes on all confirmation questions", default=False)
parser.add_option("-r", "--remove", dest="remove", action="store_true",
    help="Remove the specified repository", default=False)

(options, args) = parser.parse_args()


#****************************************************************************
def Stats(*args):
    print 'Report generating functions are in the "pstats" module\a'

def main():
    usage = "profile.py [-o output_file_path] [-s sort] scriptfile [arg] ..."
    parser = OptionParser(usage=usage)
    parser.allow_interspersed_args = False
    parser.add_option('-o', '--outfile', dest="outfile",
        help="Save stats to <outfile>", default=None)
    parser.add_option('-s', '--sort', dest="sort",
        help="Sort order when printing to stdout, based on pstats.Stats class",
        default=-1)

    if not sys.argv[1:]:
        parser.print_usage()
        sys.exit(2)

    (options, args) = parser.parse_args()
    sys.argv[:] = args

    if len(args) > 0:
        progname = args[0]
        sys.path.insert(0, os.path.dirname(progname))
        with open(progname, 'rb') as fp:
            code = compile(fp.read(), progname, 'exec')
        globs = {
            '__file__': progname,
            '__name__': '__main__',
            '__package__': None,
        }
        runctx(code, globs, None, options.outfile, options.sort)
    else:
        parser.print_usage()
    return parser

# When invoked as main program, invoke the profiler on a script
if __name__ == '__main__':
    main()


#****************************************************************************
def command_line():
    """
    By default the watched path is '/tmp' and all types of events are
    monitored. Events monitoring serves forever, type c^c to stop it.
    """
    from optparse import OptionParser

    usage = "usage: %prog [options] [path1] [path2] [pathn]"

    parser = OptionParser(usage=usage)
    parser.add_option("-v", "--verbose", action="store_true",
                      dest="verbose", help="Verbose mode")
    parser.add_option("-r", "--recursive", action="store_true",
                      dest="recursive",
                      help="Add watches recursively on paths")
    parser.add_option("-a", "--auto_add", action="store_true",
                      dest="auto_add",
                      help="Automatically add watches on new directories")
    parser.add_option("-e", "--events-list", metavar="EVENT[,...]",
                      dest="events_list",
                      help=("A comma-separated list of events to watch for - "
                           "see the documentation for valid options (defaults"
                           " to everything)"))
    parser.add_option("-s", "--stats", action="store_true",
                      dest="stats",
                      help="Display dummy statistics")
    parser.add_option("-V", "--version", action="store_true",
                      dest="version",  help="Pyinotify version")
    parser.add_option("-f", "--raw-format", action="store_true",
                      dest="raw_format",
                      help="Disable enhanced output format.")
    parser.add_option("-c", "--command", action="store",
                      dest="command",
                      help="Shell command to run upon event")

    (options, args) = parser.parse_args()

    if options.verbose:
        log.setLevel(10)

    if options.version:
        print(__version__)

    if not options.raw_format:
        global output_format
        output_format = ColoredOutputFormat()

    if len(args) < 1:
        path = '/tmp'  # default watched path
    else:
        path = args

    # watch manager instance
    wm = WatchManager()
    # notifier instance and init
    if options.stats:
        notifier = Notifier(wm, default_proc_fun=Stats(), read_freq=5)
    else:
        notifier = Notifier(wm, default_proc_fun=PrintAllEvents())

    # What mask to apply
    mask = 0
    if options.events_list:
        events_list = options.events_list.split(',')
        for ev in events_list:
            evcode = EventsCodes.ALL_FLAGS.get(ev, 0)
            if evcode:
                mask |= evcode
            else:
                parser.error("The event '%s' specified with option -e"
                             " is not valid" % ev)
    else:
        mask = ALL_EVENTS

    # stats
    cb_fun = None
    if options.stats:
        def cb(s):
            sys.stdout.write(repr(s.proc_fun()))
            sys.stdout.write('\n')
            sys.stdout.write(str(s.proc_fun()))
            sys.stdout.write('\n')
            sys.stdout.flush()
        cb_fun = cb

    # External command
    if options.command:
        def cb(s):
            subprocess.Popen(options.command, shell=True)
        cb_fun = cb

    log.debug('Start monitoring %s, (press c^c to halt pyinotify)' % path)

    wm.add_watch(path, mask, rec=options.recursive, auto_add=options.auto_add)
    # Loop forever (until sigint signal get caught)
    notifier.loop(callback=cb_fun)


if __name__ == '__main__':
    command_line()

#****************************************************************************
def main(argv):

    #
    # Parse command line arguments.
    #
    parse = OptionParser()
    parse.add_option("-v", "--verbose", dest="verbose", action="store_true", default=False, help = "switch on verbose")
    parse.add_option("-a", "--autopath", dest="autopath", action="store_true", default=False, help = "switch on autopath")
    parse.add_option("-w", "--webservice", dest="style", action="store_const", const="WEBSERVICE", help = "connect to webservice")
    parse.add_option("-b", "--batch", dest="batch_file", help = "script file to execute")
    parse.add_option("-c", dest="command_line", help = "command sequence to execute")
    parse.add_option("-o", dest="opt_line", help = "option line")
    
    global g_fVerbose, g_sScriptFile, g_fBatchMode, g_fHasColors, g_fHasReadline, g_sCmd
    
    (options, args) = parse.parse_args()
    
    g_fVerbose = options.verbose
    style = options.style
    if options.batch_file is not None:
        g_fBatchMode = True
        g_fHasColors = False
        g_fHasReadline = False
        g_sScriptFile = options.batch_file
    if options.command_line is not None:
        g_fHasColors = False
        g_fHasReadline = False
        g_sCmd = options.command_line

    params = None
    if options.opt_line is not None:
        params = {}
        strparams = options.opt_line
        strparamlist = strparams.split(',')
        for strparam in strparamlist:
            (key, value) = strparam.split('=')
            params[key] = value

    if options.autopath:
        asLocations = [ os.getcwd(), ]
        try:    sScriptDir = os.path.dirname(os.path.abspath(__file__))
        except: pass # In case __file__ isn't there.
        else:
            if platform.system() in [ 'SunOS', ]:
                asLocations.append(os.path.join(sScriptDir, 'amd64'))
            asLocations.append(sScriptDir)


        sPath = os.environ.get("VBOX_PROGRAM_PATH")
        if sPath is None:
            for sCurLoc in asLocations:
                if   os.path.isfile(os.path.join(sCurLoc, "VirtualBox")) \
                  or os.path.isfile(os.path.join(sCurLoc, "VirtualBox.exe")):
                    print("Autodetected VBOX_PROGRAM_PATH as", sCurLoc)
                    os.environ["VBOX_PROGRAM_PATH"] = sCurLoc
                    sPath = sCurLoc
                    break
        if sPath:
            sys.path.append(os.path.join(sPath, "sdk", "installer"))

        sPath = os.environ.get("VBOX_SDK_PATH")
        if sPath is None:
            for sCurLoc in asLocations:
                if os.path.isfile(os.path.join(sCurLoc, "sdk", "bindings", "VirtualBox.xidl")):
                    sCurLoc = os.path.join(sCurLoc, "sdk")
                    print("Autodetected VBOX_SDK_PATH as", sCurLoc)
                    os.environ["VBOX_SDK_PATH"] = sCurLoc
                    sPath = sCurLoc
                    break
        if sPath:
            sCurLoc = sPath
            sTmp = os.path.join(sCurLoc, 'bindings', 'xpcom', 'python')
            if os.path.isdir(sTmp):
                sys.path.append(sTmp)
            del sTmp
        del sPath, asLocations


    #
    # Set up the shell interpreter context and start working.
    #
    from vboxapi import VirtualBoxManager
    oVBoxMgr = VirtualBoxManager(style, params)
    ctx = {
        'global':       oVBoxMgr,
        'vb':           oVBoxMgr.getVirtualBox(),
        'const':        oVBoxMgr.constants,
        'remote':       oVBoxMgr.remote,
        'type':         oVBoxMgr.type,
        'run':          lambda cmd, args: runCommandCb(ctx, cmd, args),
        'guestlambda':  lambda uuid, guestLambda, args: runGuestCommandCb(ctx, uuid, guestLambda, args),
        'machById':     lambda uuid: machById(ctx, uuid),
        'argsToMach':   lambda args: argsToMach(ctx, args),
        'progressBar':  lambda p: progressBar(ctx, p),
        'typeInGuest':  typeInGuest,
        '_machlist':    None,
        'prompt':       g_sPrompt,
        'scriptLine':   0,
        'interrupt':    False,
    }
    interpret(ctx)

    #
    # Release the interfaces references in ctx before cleaning up.
    #
    for sKey in list(ctx.keys()):
        del ctx[sKey]
    ctx = None
    gc.collect()

    oVBoxMgr.deinit()
    del oVBoxMgr

if __name__ == '__main__':
    main(sys.argv)

