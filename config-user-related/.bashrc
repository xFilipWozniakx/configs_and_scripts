#!/bin/bash
#Prompt settings:
PS1='\[\e[33m\]\h: $\[\e[0m\] \[\e[31m\]\w\[\e[0m\]\n   \[\e[32m\]'



# editors:
export EDITOR="nvim"
export VISUAL="nvim"
export LOCAL=~/.local/bin

# bash_history
HISTCONTROL="ls:cd:clear"
HISTFILE=~/.bash_history
HISTSIZE=5000
shopt -s histappend

#Alias:
alias grep='grep -i'
alias infor='vim /data/configs_and_scripts/scripts-user-related/files/notifications/informations'
alias sr='source ~/.bashrc'
alias ls="ls -lah --color=always"

nick=$(whoami)
if [[ "$HOSTNAME" == "archlinux" && "$nick" == "Filip" ]]; then

  #ENV VARIABLES HOST
  export lab_path="/data/lab"
	export configs_path="/data/configs_and_scripts"
  export PATH="$PATH:$HOME/.local/bin:$HOME/.rd/bin"
  export service=/home/Filip/.config/systemd/user/
  alias CONFIG="$HOME/.config/hypr"

  UBUNTU_CONFIG_KEY="$HOME/.ssh/ssh_keys/master-key"
  OBSIDIAN_NOTES_KEY="$HOME/.ssh/ssh_keys/obsidian-notes"
  LAB_KEY="$HOME/.ssh/ssh_keys/lab-repo"


  #bash completion
  source /usr/share/bash-completion/bash_completion
  source <(kubectl completion bash)
  complete -o default -F __start_kubectl k


  # aliases on host
  alias pi="ssh -i ~/.ssh/ssh_keys/alpine-pi subadmin@10.0.0.15"
  alias python3.13=/opt/python3custom/python3.13.15/bin/python3
  alias hypr='vim ~/.config/hypr/hyprland.lua'
  alias virt="qemu-system-x86_64"
  alias debian="qemu-system-x86_64 -hda /data/vm_hdd/debian.img -hdb /data/vm_hdd/boot-experimenting.img -m 2048 -enable-kvm -netdev user,id=net0,hostfwd=tcp::2222-:22 -device virtio-net-pci,netdev=net0"
  alias vmka='ssh -p 2222 root@127.0.0.1'
  alias lpic='papers ~/Documents/LPIC/LPI-Learning-Material-101-500-en.pdf'
  alias image='swayimg'
  alias lab='ssh -i ~/.ssh/ssh_keys/arch_linux superuser@home-lab'
  alias h="helm"
  alias k="kubectl"
  alias vim="nvim -u ~/.vimrc"
  alias homarr='k port-forward -n homarr homarr-57d8df498d-mrkvj 8080:7575 &'
  #show me the key
  alias showmethekey="showmethekey-gtk -A" 
  alias showmethekey-s="gsettings set one.alynx.showmethekey clickable false"

  # tmux && agent
	if [[ -z "$TMUX" && $- == *i* ]]; then
	        if [[ $(pgrep ssh-agent | wc -l) -eq 0 ]]; then
			eval "$(ssh-agent 2>/dev/null)" && ssh-add "$OBSIDIAN_NOTES_KEY" && ssh-add "$UBUNTU_CONFIG_KEY" && ssh-add "$LAB_KEY"
		fi
		exec tmux
		tmux set-environment -g SSH_AUTH_SOCK "$SSH_AUTH_SOCK" && tmux set-environment -g SSH_AGENT_PID "$SSH_AGENT_PID"
	fi
elif [[ "$HOSTNAME" == "home-lab" ]];then
	export lab_path="${HOME}/lab"
	export configs_path="${HOME}/configs-scripts"
  # fix ssh-agent on ubuntu server
fi
