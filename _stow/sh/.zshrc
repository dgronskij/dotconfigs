echo "this is .zshrc" >&2
# fpath+=~/.zfunc
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="af-magic"
ZSH_THEME="agnoster"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git conda-zsh-completion
)

if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# Keep shell editing behavior identical on every machine, regardless of
# $EDITOR or whether Oh My Zsh is installed.
bindkey -e

fpath+=~/.zfunc  # custom competions go here

# https://gist.github.com/ctechols/ca1035271ad134841284
#
# well, this is slow as hell
# unfortunately, oh-my-zsh itself runs compinit
# have to do something with that
autoload -U compinit && compinit


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if (( $+commands[fzf] )); then
    source <(fzf --zsh)
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/miniconda3/etc/profile.d/conda.sh"
fi
# <<< conda initialize <<<


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="$HOME/.poetry/bin:$PATH"

if type zoxide &>/dev/null ; then
    eval "$(zoxide init zsh)"
fi

if type starship &>/dev/null ; then
    eval "$(starship init zsh)"
fi

if [ -f ~/bin/iterm_set_badge ] ; then
    # it turned out to be hard to set up ssh LocalCommand in ~/.ssh/config and finilizer here
    # we should change the badge only for interactive shells but should not for scipts:
    # like `ssh vagrant ls -la`
    # LocalCommand seems to not be able to differentiate one from another
    # Thus, all logic is kept here: we are setting  badges only in cases where we 100% want to
    ssh() {
        if [[ $# == 1 ]] ; then
            ~/bin/iterm_set_badge "$1"
            command ssh "$@"
            ~/bin/iterm_set_badge ""
        else
            command ssh "$@"
        fi
    }
fi

[[ -r "$HOME/.yql/shell_completion" ]] && source "$HOME/.yql/shell_completion"

# Homebrew lives in different prefixes on Linux, Apple Silicon, and Intel Macs.
for brew_prefix in /home/linuxbrew/.linuxbrew /opt/homebrew /usr/local; do
    [[ -d "$brew_prefix/opt/postgresql@16/bin" ]] && path=("$brew_prefix/opt/postgresql@16/bin" $path)
done
unset brew_prefix

export NVM_DIR="$HOME/.nvm"
for nvm_script in \
    "$NVM_DIR/nvm.sh" \
    /home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh \
    /opt/homebrew/opt/nvm/nvm.sh \
    /usr/local/opt/nvm/nvm.sh; do
    if [[ -s "$nvm_script" ]]; then
        source "$nvm_script"
        break
    fi
done
unset nvm_script


# The next line enables shell completion for TARS utility
[[ -r "$HOME/.tars/shell/rc_ext.zsh" ]] && source "$HOME/.tars/shell/rc_ext.zsh"
