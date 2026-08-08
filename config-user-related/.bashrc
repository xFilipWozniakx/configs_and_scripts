#!/bin/bash
#Prompt settings:
PS1='\[\e[33m\]\h: $\[\e[0m\] \[\e[31m\]\w\[\e[0m\]\n   \[\e[32m\]'

# Aliases:
alias ls="ls -lah" 

# bash_history
HISTFILE=~/Documents/.bash_history
HISTSIZE=5000
shopt -s histappend



# Environment variables:
UBUNTU_CONFIG_KEY="$HOME/.ssh/ssh_keys/master-key"
OBSIDIAN_NOTES_KEY="$HOME/.ssh/ssh_keys/obsidian-notes"
LAB_KEY="$HOME/.ssh/ssh_keys/lab-repo"

#Navigating
cfgs="/data/ubuntu-server-configs/config-user-related"
bin=~/.local/bin/

#Exports:
export PATH="$PATH:$HOME/.local/bin"

#Alias:
alias hypr='vim ~/.config/hypr/hyprland.lua'
alias virt="qemu-system-x86_64"
alias debian="qemu-system-x86_64 -hda /data/vm_hdd/debian.img -hdb /data/vm_hdd/boot-experimenting.img -m 2048 -enable-kvm -netdev user,id=net0,hostfwd=tcp::2222-:22 -device virtio-net-pci,netdev=net0"
alias lsusb="cyme"
alias vmka='ssh -p 2222 root@127.0.0.1'
alias grep='grep -i'
alias lpic='papers ~/Documents/LPIC/LPI-Learning-Material-101-500-en.pdf'
alias image='swayimg'
#show me the key
alias showmethekey="showmethekey-gtk -A" 
alias showmethekey-s="gsettings set one.alynx.showmethekey clickable false"
alias sr='source ~/.bashrc'

nick=$(whoami)
if [[ "$HOSTNAME" == "archlinux" && "$nick" == "Filip" ]]; then
	
	# tmux && agent
	if [[ -z "$TMUX" && $- == *i* ]]; then
	        if [[ $(pgrep ssh-agent | wc -l) -eq 0 ]]; then
			eval "$(ssh-agent 2>/dev/null)" && ssh-add "$OBSIDIAN_NOTES_KEY" && ssh-add "$UBUNTU_CONFIG_KEY" && ssh-add "$LAB_KEY"
		fi
		exec tmux
		tmux set-environment -g SSH_AUTH_SOCK "$SSH_AUTH_SOCK" && tmux set-environment -g SSH_AGENT_PID "$SSH_AGENT_PID"
	fi
fi
