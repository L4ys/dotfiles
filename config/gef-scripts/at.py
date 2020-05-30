class Attach(GenericCommand):
    """Attach with current program name"""
    _cmdline_ = "at"
    _syntax_  = "{:s} [process name]".format(_cmdline_)

    @only_if_gdb_target_local
    def do_invoke(self, argv):
        if len(argv) == 1:
            procname = argv[0]
        else:
            procname = None

        try:
            data = gdb.execute("info proc exe", to_string=True)
            procname = re.findall("exe = '(.+)'", data)[0]
        except gdb.error:
            data = gdb.execute("info files", to_string=True)
            if data:
                procname = re.findall('Symbols from "(.+)"', data)[0]

        if not procname:
            print("No process name to attach")
            return

        procname = procname.split("/")[-1]
        print("Attach to {:s}...".format(procname))
        try:
            pid = next(filter(lambda x: x != str(get_pid()), gef_execute_external(["/bin/pidof", procname]).strip().split()))
        except Exception as e:
            print("No such process")
            return

        try:
            gdb.execute("attach {:s}".format(pid))
        except Exception as e:
            print("Attach Failed:")
            print(e)
        return

register_external_command(Attach())
