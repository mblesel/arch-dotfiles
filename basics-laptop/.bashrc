stty -ixon # Disabe ctrl-s and ctrl-q

# Eternal bash history.
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export MANPAGER='nvim +Man!' 

# ls aliases
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -la --color=auto'

alias grep='grep --color=auto'

# Shortcuts
alias open='xdg-open'
alias g='grep'
alias f='cd $(fd --type d --hidden --exclude Downloads --exclude .git --exclude node_module --exclude .cache --exclude .npm --exclude .mozilla | fzf)'

# rsync
alias rs='rsync -avHAXW --numeric-ids --info=progress2'
alias srs='sudo rsync -avHAXW --numeric-ids --info=progress2'

# Redo last command and put output in clipboard
alias cpl='$(history -p !!) | xclip -selection clipboard -r'
# copy pwd to clipboard
alias cpwd='pwd | xclip -selection clipboard -r'

#youtube-dl audio
alias ytd='yt-dlp -f ba'

#pingtest
alias pt='ping 8.8.8.8'

#source bashrc
alias src='source ~/.bashrc'

# zk
alias zki='zk edit --interactive'
alias zkn='nvim ~/Documents/cloud/ZK/kc2v-note.md'

# vim / nvim
alias vim='nvim'
alias vi='/usr/bin/vim'
alias vimconf='cd /home/michael/.config/nvim/lua/; nvim; cd -'
export ZK_NOTEBOOK_DIR='/home/michael/Documents/cloud/ZK/'

# samedir
alias samedir='st -d "$(pwd)" &> /dev/null & disown'

# Kitty image viewer
alias icat='kitty icat'

# tmux-sessionizer
bind '"\ef":"tmux-sessionizer\n"'

PS1='[\u@\h \W]\$ '

# source /usr/share/doc/pkgfile/command-not-found.bash

# load spack
# . /etc/modules/init/bash
# . /home/michael/Projects/spack/share/spack/setup-env.sh

# load spackter
. /home/michael/Projects/spackter/setup-env.sh
# . $(spackter load main --only-env-script)

# secret ENVVARS
. /home/michael/.secrets

# opam configuration
test -r /home/michael/.opam/opam-init/init.sh && . /home/michael/.opam/opam-init/init.sh >/dev/null 2>/dev/null || true

webmTOmp4() {
    ffmpeg -i "$1".webm -qscale 0 "$1".mp4
}

eval "$(starship init bash)"
