# Path Updates
set -a PATH $HOME/.local/bin

source "$HOME/.homesick/repos/homeshick/homeshick.fish"

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

# load additional dotfiles if they are set up on this computer
if [ -f $HOME/customizations/fish/config.fish ]; source $HOME/customizations/fish/config.fish; end
