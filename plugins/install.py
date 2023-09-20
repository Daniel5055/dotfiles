import dotbot
import traceback
from shutil import which
from os.path import expandvars, isfile

class Install(dotbot.Plugin):
    """
    Plugin for installing dependencies if the specified commands are not available

    Operates essentially the same as the shell command for now, except that 'for' directive exists,
    which is a list of the commands to check if they exist, else run the script
    """

    _directive = "install"

    def can_handle(self, directive):
        return directive == self._directive

    def handle(self, directive, data):
        if directive != self._directive:
            raise ValueError("Install cannot handle directive {}".format(directive))

        try:
            defaults = self._context.defaults().get("install", {})
            stdout = defaults.get("stdout", False)
            stderr = defaults.get("stderr", False)
            stdin = defaults.get("stdin", False)
            success = True

            # Advanced labelling
            if isinstance(data, dict):
                for dependency, options in data.items():
                    cmd = options.get("command", None)

                    if cmd is None:
                        self._log.error("Install dependency requires directive 'command'")
                        return False

                    msg = options.get("description", None)

                    # for either expects a single command, or list of commands
                    targets = options.get("for", None)
                    target_commands = []
                    target_files = []
                    target_tests = []

                    if isinstance(targets, dict):
                        target_commands = targets.get('command', [])
                        target_files = targets.get('file', [])
                        target_tests = targets.get('test', [])
                        if not isinstance(target_commands, list):
                            target_commands = [target_commands]
                        if not isinstance(target_files, list):
                            target_files = [target_files]
                        if not isinstance(target_tests, list):
                            target_tests = [target_tests]
                    elif isinstance(targets, list):
                        target_commands = targets
                    elif targets is not None:
                        target_commands = [targets]

                    # Apparently python doesn't use 'which' command in backend so should be fine
                    missing_commands = list(filter(lambda t: which(t) is None, target_commands))
                    missing_files = list(filter(lambda t: not isfile(expandvars(t)), target_files))
                    failing_tests = list(filter(lambda t: dotbot.util.shell_command(
                            target_tests,
                            cwd=self._context.base_directory()
                        ) != 0, target_tests))

                    if any(map(lambda t: len(t), [missing_commands, missing_files, failing_tests])):
                        # Plurality
                        pl = "s" if len(missing_commands) > 1 else ""
                        if len(missing_commands) > 0:
                            self._log.warning("Missing following command{} for {}: {}".format(
                                pl,
                                dependency,
                                "".join(map(lambda t: "\n - " + missing_commands)),
                            ))

                        pl = "s" if len(missing_files) > 1 else ""
                        if len(missing_files) > 0:
                            self._log.warning("Missing following file{} for {}: {}".format(
                                pl,
                                dependency,
                                "".join(map(lambda t: "\n - " + t, missing_files)),
                            ))

                        pl = "s" if len(failing_tests) > 1 else ""
                        if len(failing_tests) > 0:
                            self._log.warning("Failing following test{} for {}: {}".format(
                                pl,
                                dependency,
                                "".join(map(lambda t: "\n - " + t, failing_tests)),
                            ))

                        self._log.lowinfo("└ {}".format(msg))

                        stdout = options.get("stdout", stdout)
                        stderr = options.get("stderr", stderr)
                        ret = dotbot.util.shell_command(
                            cmd,
                            cwd=self._context.base_directory(),
                            enable_stdin=stdin,
                            enable_stdout=stdout,
                            enable_stderr=stderr,
                        )

                        if ret != 0:
                            success = False
                            self._log.warning("Command [{}] failed".format(cmd))
                            pass
                    else:
                        self._log.lowinfo("{} already installed".format(dependency))

            if success:
                self._log.info("All necessary dependencies have been installed")
            else:
                self._log.error("Some dependencies failed to install successfully")

            return success

        except:
            self._log.error("Error occured in install plugin")
            self._log.error(traceback.format_exc())

