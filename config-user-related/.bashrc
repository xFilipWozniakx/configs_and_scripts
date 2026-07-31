#Prompt settings:
PS1='\[\e[33m\]\h: $\[\e[0m\] \[\e[31m\]\w\[\e[0m\]\n   \[\e[32m\]'

# Aliases:
alias ls="ls -lah" 


# Keys:
if [[ -z "$SSH_AUTH_SOCK" ]];then
	eval $(ssh-agent -a $HOME/.ssh/agent/agent.sock) 
	clear
fi

# Environment variables:
UBUNTU_CONFIG_KEY="$HOME/.ssh/ssh_keys/master-key"
OBSIDIAN_NOTES_KEY="$HOME/.ssh/ssh_keys/obsidian-notes"


#Navigating
cfgs="/data/ubuntu-server-configs/config-user-related"


#Exports:
export PATH="$PATH:$HOME/.local/bin"


nick=$(whoami)
if [[ "$HOSTNAME" == "archlinux" && "$nick" == "Filip" ]]; then
	[[ -z "$TMUX" ]] && tmux  
	if [[ $(ssh-add -l | wc -l) -gt 0 ]]; then
		eval $(ssh-add "$OBSIDIAN_NOTES_KEY" >/dev/null 2>&1)
		echo "notes added to agent"
	fi
fi

