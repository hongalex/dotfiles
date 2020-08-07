# Path Updates
set -a PATH $HOME/.local/bin ~/development/flutter/bin $HOME/bin

# Prepend gnubin to $PATH so GNU sed works
switch (uname)
  case Darwin
    # Prepend gnubin to $PATH so GNU sed works
    set -gx PATH /usr/local/opt/gnu-sed/libexec/gnubin $PATH
    function hb-permissions
      sudo chown -R (whoami) /usr/local/bin /usr/local/etc /usr/local/sbin /usr/local/share /usr/local/share/doc
      chmod u+w /usr/local/bin /usr/local/etc /usr/local/sbin /usr/local/share /usr/local/share/doc
    end
end

# load additional dotfiles if they are set up on this computer
if [ -f $HOME/customizations/fish/config.fish ]; source $HOME/customizations/fish/config.fish; end

# load homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"

# load direnv
eval (direnv hook fish)

# gcloud sdk
alias gcpl "gcloud config list project"
alias gcl "gcloud config list"
function gcsp
    gcloud config set project $argv
    export GCLOUD_PROJECT=$argv
    export GOOGLE_CLOUD_PROJECT=$argv
    export GOLANG_SAMPLES_PROJECT_ID=$argv
end

function printcloud
    repeat _ 95
    printf "|%-40s | %-50s|\n" "KEY" "VALUE"
    repeat - 95
    printf "|%-40s | %-50s|\n" "GOOGLE_APPLICATION_CREDENTIALS" $GOOGLE_APPLICATION_CREDENTIALS
    printf "|%-40s | %-50s|\n" "GOOGLE_CLOUD_PROJECT" $GOOGLE_CLOUD_PROJECT
    printf "|%-40s | %-50s|\n" "GCLOUD_PROJECT" $GCLOUD_PROJECT
    repeat - 95
    gcl
end

# Git aliases
alias gpush "git push"
alias gpull "git pull"
alias gs "git status"
alias gm "git commit -m"
alias gaa "git add ."
alias gd "git diff"
alias gco "git checkout"
alias gdt "git tag | xargs -n 1 -I% git tag -d % && git fetch"

# cd aliases
alias cdproject "cd ~/projects"
alias cdproj "cdproject"
alias cdnode "cd ~/projects/samples/nodejs-docs-samples"
alias cdpython "cd ~/projects/samples/python-docs-samples"
alias cdalpha "cd ~/projects/alphav2"
alias cdcred "cd ~/customizations/credentials"
alias cdgo "cd ~/.go/src"
alias cdgos "cd ~/.go/src/github.com/GoogleCloudPlatform/golang-samples/pubsub"
alias cdgoc "cd ~/.go/src/cloud.google.com/go/pubsub"
alias cdpsnode "cd $HOME/projects/client-libraries/nodejs-pubsub"
alias cdcl "cd $HOME/projects/client-libraries"
alias cdfish "cd $HOME/.config/fish"
alias cdgproto "cd $HOME/.go/src/google.golang.org/genproto"

# misc aliases
alias docker-cleanup='docker ps -a -q | xargs -I {} docker rm {} ; docker images -q -f dangling=true | xargs -I {} docker rmi -f {}; docker volume ls -qf dangling=true | xargs -I {} docker volume rm {}'

# Rust
set -a PATH $HOME/.cargo/bin

# Java
export M2_HOME=/usr/local/Cellar/maven/3.6.3_1/libexec
export M2=$M2_HOME/bin
set -a PATH $M2_HOME/bin
set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths

# utility aliases
alias sfish "source $HOME/.config/fish/config.fish"
alias rcp "rsync -rav --progress"

function repeat -a char -a length
    printf '%*s\n' $length "" | tr ' ' $char
end

function measure
    set -l ts (date +%s%N)
    eval $argv
    set -l tt (math (math (date +%s%N) - $ts)/1000000)
    echo "time took: $tt ms." >&2
end

function goto
    cd (dirname (which $argv[1]))
end

# execute last command
function !!
    set var (history | head -n 1)
    if test $argv
        if test $argv = "sudo" #; or "any other command you want to prepend"
            eval $argv $var
        else
            eval $var $argv
        end
    else
        eval $var
    end
end

# MOTD
function echo_color
	set -l color "$1"
	printf "$2\n"
end

echo_color "\033[0;90m" "c-f  Move forward"
echo_color "\033[0;90m" "c-b  Move backward"
echo_color "\033[0;90m" "c-p  Move up"
echo_color "\033[0;90m" "c-n  Move down"
echo_color "\033[0;90m" "c-a  Jump to beginning of line"
echo_color "\033[0;90m" "c-e  Jump to end of line"
echo_color "\033[0;90m" "c-d  Delete forward"
echo_color "\033[0;90m" "c-h  Delete backward"
echo_color "\033[0;90m" "c-k  Delete forward to end of line"
echo_color "\033[0;90m" "c-u  Delete entire line"
