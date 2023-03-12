echo "this is .profie"
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

source ~/bin/sshutils.incl.sh
source ~/bin/makeenv.incl.sh
_sshutils_relink_ssh_auth

export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export GRONSKY_PROFILE_GET_PROJECT_FILES_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_COMMAND="$GRONSKY_PROFILE_GET_PROJECT_FILES_COMMAND"

# export GRONSKY_PROFILE_GET_PROJECT_FILES_COMMAND='rg --files'
# export FZF_DEFAULT_COMMAND="$GRONSKY_PROFILE_GET_PROJECT_FILES_COMMAND"

export GOPATH="${HOME}/.go"
export GOROOT="/home/linuxbrew/.linuxbrew/opt/go/libexec"  # "$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
#export GOPRIVATE=gitlab.ozon.ru
export GOPROXY="https://goproxy.s.o3.ru"
export GOSUMDB="off"



#alias mrtrunk="cd ~/mailru/trunk/trunk"
#alias mrscripts="cd ~/mailru/trunk/trunk/scripts/china_ranking"
#alias mrtest="cd ~/mailru/trunk/trunk/tmp"
#alias mrsadcoconf="cd ~/mailru/other/sadco-config; git pull"
#alias mrskill="cd ~/mailru/trunk/skillserver"

#alias cat=bat
#alias less=bat

alias tma="tmux attach"

source ~/bin/gitutils
export GIT_SRC_ROOT=$HOME/src

alias g="git"
alias lg="lazygit"

alias gs="__git_switch_repos ~/src/gitlab.ozon.ru"
alias ml="__git_switch_repos ~/src/gitlab.ozon.ru/data_science/mlp"
alias 3p="__git_switch_repos ~/src/github.com"
alias om="__git_switch_repos ~/src/python_course_2022"


alias k-prod-ds="kubectl --context=o-prod --namespace ds"
alias k-dev-ds="kubectl --context=o-dev --namespace ds"
alias k-stg-ds="kubectl --context=o-stg --namespace ds"

alias por="poetry run"
alias pvim="poetry run vim"

nvimconf() {
    ( cd ~/.config/nvim && exec nvim )
}


#alias geturl="svn info | grep '^URL' | awk -F': ' '{print "'$2'";}'"
#alias getbranch="svn info | grep '^Relative URL' | awk -F': ' '{print "'$2'";}'"

export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export EDITOR="vim"

TZ='Europe/Moscow'; export TZ

# eval `ssh-agent -s`  # this gonna be a mess for many logins :(

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"

eval "$(pyenv init --path)"
eval "$(pyenv init -)"


# https://asdf-vm.com/guide/getting-started.html#_2-download-asdf
. $(brew --prefix asdf)/libexec/asdf.sh


# >>> coursier install directory >>>
export PATH="$PATH:/home/d.gronsky/.local/share/coursier/bin"
# <<< coursier install directory <<<
