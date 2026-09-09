#!/bin/bash
#Prompt settings:
PS1='\[\e[33m\]\h: $\[\e[0m\] \[\e[31m\]\w\[\e[0m\]\n   \[\e[32m\]'

# editors:
export EDITOR="nvim"
export VISUAL="nvim"
export LOCAL=~/.local/bin
export SSH="$HOME/.ssh/ssh_keys"

# bash_history
HISTCONTROL="ignoreboth"
HISTIGNORE="ls:cd:clear:lab:exit:ls:history:pass:nvim"
HISTFILE=~/.bash_history
HISTSIZE=5000
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

#Alias:
alias grep='grep -i --color=always'
alias sr='source ~/.bashrc'
alias ls="ls -lah --color=always"
alias gs="git status"
alias gc="git commit -m"
alias lz="lazygit"
alias d="docker"

[[ -f ~/.bashrc_local ]] && source ~/.bashrc_local


nick=$(whoami)
if [[ "$HOSTNAME" == "archlinux" && "$nick" == "Filip" ]]; then

  #PROJECTS
  export ftp="/home/Filip/Projects/my-ftp/docker-build"
  #QUICK MOVING
  export LAB="/data/k3s+flux"
  export BITCOIN="/home/Filip/Projects/coinmarketcap-api"
  #ENV VARIABLES HOST
  export PATH="$PATH:$HOME/.local/bin:$HOME/.rd/bin"
  export CONFIG="$HOME/.config/hypr"
  UBUNTU_CONFIG_KEY="$SSH/master-key"
  OBSIDIAN_NOTES_KEY="$SSH/obsidian-notes"
  LAB_KEY="$SSH/lab-repo"
  alias reco="flux reconcile kustomization apps"


  #bash completion
  . /usr/share/bash-completion/bash_completion
  . <(kubectl completion bash)
  complete -o default -F __start_kubectl k
  complete -o default -F __start_flux f
  . <(flux completion bash)
  complete -o default -F __start_docker d
  . <(docker completion bash)
  . <(helm completion bash)
  complete -o default -F __start_helm h

  export KUBECONFIG="$HOME/.config/kube/config/k3s.yaml"
  alias f="flux"
  alias k="kubectl"
  alias k9s="k9s"
  alias h="helm"

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
  alias vim="nvim -u ~/.vimrc"
  #show me the key
  alias showmethekey="showmethekey-gtk -A"
  alias showmethekey-s="gsettings set one.alynx.showmethekey clickable false"
  alias wl="wl-copy"

  # PASS ALIASES:
  alias piad="pass show --clip pi/subadmin"
  alias clad="pass show --clip cluster/superuser"

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
  alias k="kubectl"
fi
