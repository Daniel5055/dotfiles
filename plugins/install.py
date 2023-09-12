import dotbot
import traceback
from shutil import which

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
            self._log.info(data)

            defaults = self._context.defaults().get("install", {})
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
                    targets = options.get("for", [])
                    if not isinstance(targets, list):
                        targets = [targets]

                    stdin = defaults.get("stdin", False)
                    stdout = defaults.get("stdout", False)
                    stderr = defaults.get("stderr", False)

                    # Apparently python doesn't used 'which' command in backend so should be fine
                    missing_targets = list(filter(lambda t: which(t) is None, targets))
                    if len(missing_targets) > 0:

                        # Plurality
                        if len(missing_targets) == 1:
                            self._log.warning("Missing following command for {}: {}".format(dependency, ",".join(missing_targets)))
                        else:
                            self._log.warning("Missing following commands {}: {}".format(dependency, ",".join(missing_targets)))

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
                        self._log.lowinfo("Commands exist for {}".format(dependency))

            if success:
                self._log.info("All necessary dependencies have been installed")
            else:
                self._log.error("Some dependencies failed to install successfully")

            return success

        except:
            self._log.error("Error occured in install plugin")
            self._log.error(traceback.format_exc())

