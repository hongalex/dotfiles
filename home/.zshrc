export TERM="xterm-256color"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=/usr/lib/go/bin:$PATH
export PATH=$PATH:/mnt/c/Windows/System32
export PATH=$PATH:/mnt/c/Users/Alex/AppData/Local/Programs/Microsoft\ VS\ Code/bin

# Flutter
export PATH=$PATH:$HOME/development/flutter/bin

# gcloud sdk
if [[ -f '/Users/hongalex/google-cloud-sdk/path.fish.inc' ]]; then
	. '/Users/hongalex/google-cloud-sdk/path.zsh.inc';
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# load additional dotfiles if they are set up on this computer
if [[ -f $HOME/customizations/google.zsh ]];
	then source $HOME/customizations/google.zsh
fi

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# How often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git zsh-autosuggestions)

export ZSH_DISABLE_COMPFIX="true"

source $ZSH/oh-my-zsh.sh

# User configuration
# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'
fi


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

# Git aliases
alias gpush="git push"
alias gpull="git pull"
alias gs="git status"
alias gm="git commit -m"
alias gaa="git add ."
alias gd="git diff"
alias gco="git checkout"
alias gdt="git tag | xargs -n 1 -I% git tag -d % && git fetch"

# cd aliases
alias cdproject="cd ~/projects"
alias cdproj="cdproject"
alias cdnode="cd ~/projects/samples/nodejs-docs-samples"
alias cdpython="cd ~/projects/samples/python-docs-samples"
alias cdalpha="cd ~/projects/alphav2"
alias cdcred="cd ~/customizations/credentials"
alias cdgo="cd ~/.go/src"
alias cdgos="cd ~/.go/src/github.com/GoogleCloudPlatform/golang-samples/pubsub"
alias cdgoc="cd ~/.go/src/cloud.google.com/go/pubsub"
alias cdpsnode="cd $HOME/projects/client-libraries/nodejs-pubsub"
alias cdcl="cd $HOME/projects/client-libraries"
alias cdfish="cd $HOME/.config/fish"
alias cdgproto="cd $HOME/.go/src/google.golang.org/genproto"

# misc aliases
alias docker-cleanup="docker ps -a -q | xargs -I {} docker rm {} ; docker images -q -f dangling=true | xargs -I {} docker rmi -f {}; docker volume ls -qf dangling=true | xargs -I {} docker volume rm {}"

# utility aliases
alias sz="source $HOME/.zshrc"
alias zshconfig="vim ~/.zshrc"
alias rcp="rsync -rav --progress"

# gcloud sdk
alias gcpl="gcloud config list project"
alias gcl="gcloud config list"
function gcsp() {
		gcloud config set project $argv
		export GCLOUD_PROJECT=$argv
		export GOOGLE_CLOUD_PROJECT=$argv
		export GOLANG_SAMPLES_PROJECT_ID=$argv
}

function repeat() {
		str=$1
		num=$2
		v=$(printf "%-${num}s" "$str")
		echo "${v// /*}"
}

function printcloud() {
		repeat "_" 95
    printf "|%-40s | %-50s|\n" "KEY" "VALUE"

    printf "|%-40s | %-50s|\n" "GOOGLE_APPLICATION_CREDENTIALS" $GOOGLE_APPLICATION_CREDENTIALS
    printf "|%-40s | %-50s|\n" "GOOGLE_CLOUD_PROJECT" $GOOGLE_CLOUD_PROJECT
    printf "|%-40s | %-50s|\n" "GCLOUD_PROJECT" $GCLOUD_PROJECT
    gcl
}

GOPATH=$HOME/go
function _update_ps1() {
	    PS1="$($GOPATH/bin/powerline-go -error $?)"
    }
if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
	    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

ZSH_DISABLE_COMPFIX="true"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

prompt_context() {}

