# Set terminal window title or prompt path
# In Zsh: precmd() prints current directory (%~) in red
# In Bash: PROMPT_COMMAND runs before every prompt
set_prompt() {
    # Print working directory (~ format) in red
    printf "\e[31m%s\e[0m\n" "${PWD/#$HOME/~}"
}
PROMPT_COMMAND=set_prompt

# Main prompt: Blue username (%F{blue}%n)
# Bash uses \u for username and ANSI escapes for blue (\e[34m)
PS1='\[\e[34m\]\u\[\e[0m\] '

# History configuration
HISTFILE=~/.bash_history
HISTSIZE=1000
HISTFILESIZE=1000

# Bash Shell Options (replacing 'setopt' and 'unsetopt')
shopt -s autocd         # Automatically cd into directory if name is typed
shopt -s histappend     # Append history rather than overwriting
# Real-time history sharing across sessions (replaces Zsh SHARE_HISTORY)
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# HIST_IGNORE_DUPS -> ignore duplicate entries in history
HISTCONTROL=ignoredups

# Enable notify & disable terminal bell
set -o notify
bind 'set bell-style none'

# Keybindings (Readline bindings replacing 'bindkey' / Emacs mode)
set -o emacs

# Standard keybindings via inputrc formatting inside .bashrc
bind '"\C-h": backward-kill-word'         # Ctrl + Backspace / Ctrl + H
bind '"\e[3;5~": kill-word'               # Ctrl + Delete
bind '"\e[3~": delete-char'               # Delete key
bind '"\e[1;5D": backward-word'            # Ctrl + Left Arrow
bind '"\e[1;5C": forward-word'             # Ctrl + Right Arrow

# Aliases
alias ls='ls -lah --color=auto'
alias ip='ip -c'
alias tree="tree -aC"
alias grep="grep --color=auto -n"
alias sr='source ~/.bashrc'              # Changed to source .bashrc instead of .zshrc
alias k='kubectl'
alias rm="rm -I"
alias d="docker"
alias tmux='tmux has-session -t main 2>/dev/null || (tmux new-session -d -s main -n host && tmux new-window -t main:2 -n server && tmux send-keys -t main:2 "server" C-m) && tmux attach-session -t main'

# Word boundary behavior (Bash native equivalent to Zsh select-word-style bash)
# Excludes typical path/file symbols from being considered part of a "word"
export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'

# Environment Variables
export VISUAL='vim'
export EDITOR='vim'
export PATH="$PATH:/home/superuser/.local/bin"

# start with tmux
[[ -z tmux ]] && tmux

