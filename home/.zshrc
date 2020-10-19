export TERM="xterm-256color"

export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

# Flutter
export PATH=$PATH:$HOME/development/flutter/bin

windows='*Microsoft*'
linux='*Linux*'
mac='*Darwin*'
case `uname -a` in
$~windows)
	export PATH=$PATH:/mnt/c/Windows/System32
	export PATH=$PATH:/mnt/c/Users/Alex/AppData/Local/Programs/Microsoft\ VS\ Code/bin
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

  # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
  ZSH_THEME="powerlevel9k/powerlevel9k"
  POWERLEVEL9K_MODE='nerdfont-complete'
;;
$~mac)
  ZSH_THEME="powerlevel9k/powerlevel9k"
  # gcloud sdk
  if [[ -f '/Users/hongalex/google-cloud-sdk/path.zsh.inc' ]]; then
    . '/Users/hongalex/google-cloud-sdk/path.zsh.inc';
  fi

  export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
  function hb-permissions() {
    sudo chown -R $(whoami) /usr/local/bin /usr/local/etc /usr/local/sbin /usr/local/share /usr/local/share/doc
    chmod u+w /usr/local/bin /usr/local/etc /usr/local/sbin /usr/local/share /usr/local/share/doc
  }
;;
$~linux)
  echo "Hello Linux"
  ZSH_THEME="powerlevel10k/powerlevel10k"
;;
*)
  echo "Unsupported operating system"
  echo $(uname -a)
;;
esac

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

# load additional dotfiles if they are set up on this computer
if [[ -f $HOME/customizations/google.zsh ]];
	then source $HOME/customizations/google.zsh
fi

# How often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git zsh-autosuggestions zsh-dircolors-solarized)

export ZSH_DISABLE_COMPFIX="true"

source $ZSH/oh-my-zsh.sh

# User configuration
# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Go development
# Ignore zsh autocorrect for go commands (e.g. ./...)
# alias go="nocorrect go"
export GOPATH=$HOME/.go
export PATH=$PATH:/usr/lib/go/bin

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
alias cdproject="cd $HOME/projects"
alias cdproj="cdproject"
alias cdnode="cd $HOME/projects/samples/nodejs-docs-samples"
alias cdpython="cd $HOME/projects/samples/python-docs-samples"
alias cdalpha="cd $HOME/projects/alphav2"
alias cdcred="cd $HOME/customizations/credentials"
alias cdgo="cd $HOME/.go/src"
alias cdgos="cd $HOME/.go/src/github.com/GoogleCloudPlatform/golang-samples/pubsub"
alias cdgoc="cd $HOME/.go/src/cloud.google.com/go/pubsub"
alias cdpsnode="cd $HOME/projects/client-libraries/nodejs-pubsub"
alias cdcl="cd $HOME/projects/client-libraries"
alias cdgproto="cd $HOME/.go/src/google.golang.org/genproto"

# misc aliases
alias docker-cleanup="docker ps -a -q | xargs -I {} docker rm {} ; docker images -q -f dangling=true | xargs -I {} docker rmi -f {}; docker volume ls -qf dangling=true | xargs -I {} docker volume rm {}"

# utility aliases
alias sz="source $HOME/.zshrc"
alias zshconfig="vim ~/.zshrc"
alias rcp="rsync -rav --progress"
alias hs="homeshick"

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

