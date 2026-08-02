#Prompt settings:
PS1='\[\e[33m\]\h: $\[\e[0m\] \[\e[31m\]\w\[\e[0m\]\n   \[\e[32m\]'

# Aliases:
alias ls="ls -lah" 


# Environment variables:
UBUNTU_CONFIG_KEY="$HOME/.ssh/ssh_keys/master-key"
OBSIDIAN_NOTES_KEY="$HOME/.ssh/ssh_keys/obsidian-notes"


#Navigating
cfgs="/data/ubuntu-server-configs/config-user-related"


#Exports:
export PATH="$PATH:$HOME/.local/bin"


nick=$(whoami)
if [[ "$HOSTNAME" == "archlinux" && "$nick" == "Filip" ]]; then
	if [[ -z "$TMUX" && $- == *i* ]]; then
		exec tmux
	fi
fi


