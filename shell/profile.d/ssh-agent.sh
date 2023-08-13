# For auto ssh agent to work, one must first enable the user ssh-agent 
# Can be done by doing:
#
# ```shell
# systemctl --user enable ssh-agent
# ```

# For the auto ssh agent
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

