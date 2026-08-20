#!/bin/bash
#Prompt settings:
PS1='\[\e[33m\]\h: $\[\e[0m\] \[\e[31m\]\w\[\e[0m\]\n   \[\e[32m\]'

# editors:
export EDITOR="nvim"
export VISUAL="nvim"
export LOCAL=~/.local/bin
export SSH="$HOME/.ssh/ssh_keys"

# bash_history
HISTCONTROL="ls:cd:clear"
HISTFILE=~/.bash_history
HISTSIZE=5000
shopt -s histappend

#Alias:
alias grep='grep -i'
alias sr='source ~/.bashrc'
alias ls="ls -lah --color=always"
alias gs="git status"
alias gc="git commit -m"
alias h="helm"

[[ -f ~/.bashrc_local ]] && source ~/.bashrc_local


nick=$(whoami)
if [[ "$HOSTNAME" == "archlinux" && "$nick" == "Filip" ]]; then

  #ENV VARIABLES HOST
  export PATH="$PATH:$HOME/.local/bin:$HOME/.rd/bin"
  export CONFIG="$HOME/.config/hypr"
  UBUNTU_CONFIG_KEY="$SSH/master-key"
  OBSIDIAN_NOTES_KEY="$SSH/obsidian-notes"
  LAB_KEY="$SSH/lab-repo"
  LAB_CLUSTER="$SSH/lab-cluster"

  #bash completion
  source /usr/share/bash-completion/bash_completion
  source <(kubectl completion bash)
  complete -o default -F __start_kubectl k
  . <(flux completion bash)

  export KUBE_CONFIG="$HOME/.config/kube/config/k3s.yaml"
  alias f="flux --kubeconfig="$KUBE_CONFIG""
  alias k="kubectl --kubeconfig="$KUBE_CONFIG""
  alias k9s="k9s --kubeconfig="$KUBE_CONFIG""

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
  alias k="kubectl"
fi
