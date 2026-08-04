#!/bin/bash
#Prompt settings:
PS1='\[\e[33m\]\h: $\[\e[0m\] \[\e[31m\]\w\[\e[0m\]\n   \[\e[32m\]'

# Aliases:
alias ls="ls -lah" 


# Environment variables:
UBUNTU_CONFIG_KEY="$HOME/.ssh/ssh_keys/master-key"
OBSIDIAN_NOTES_KEY="$HOME/.ssh/ssh_keys/obsidian-notes"
LAB_KEY="$HOME/.ssh/ssh_keys/lab-repo"

#Navigating
cfgs="/data/ubuntu-server-configs/config-user-related"
bin="~/.local/bin/"

#Exports:
export PATH="$PATH:$HOME/.local/bin"

#Alias:
alias hypr='vim ~/.config/hypr/hyprland.lua'
alias virt="qemu-system-x86_64"
alias debian="qemu-system-x86_64  -hda /data/vm_hdd/debian.img -hdb /data/vm_hdd/grub.img -m 2048 -enable-kvm"

nick=$(whoami)
if [[ "$HOSTNAME" == "archlinux" && "$nick" == "Filip" ]]; then
	
	# tmux && agent
	if [[ -z "$TMUX" && $- == *i* ]]; then
	        if [[ $(pgrep ssh-agent | wc -l) -lt 2 ]]; then
			eval "$(ssh-agent 2>/dev/null)" && ssh-add "$OBSIDIAN_NOTES_KEY" && ssh-add "$UBUNTU_CONFIG_KEY" && ssh-add "$LAB_KEY"
		else
			for i in $(pgrep ssh-agent); do kill -9 "$i" ; done
		fi
		exec tmux
	fi
fi
alias lsusb="cyme"
