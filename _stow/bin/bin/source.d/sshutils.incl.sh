#!/bin/bash

# TODO: environment variable to set link location

# this function should be called in ~/.profile
function _sshutils_relink_ssh_auth() {

    local ssh_auth_sock_should_be="$HOME/.ssh/ssh_auth_sock"

    # 1. if relinked by OUR machinery, do nothing
    #     - is it equivalent to checking SSH_AUTH_SOCK value itself? I think yes
    if [[ "$SSH_AUTH_SOCK" = "$ssh_auth_sock_should_be ]] ; then
        return;
    fi

    # 2. if relinked by NOT US -- relink

    # work machine has $SSH_AUTH_SOCK relinked
    if [[ "$(hostname)" = "dgronskiy-osx" ]] ; then
        ln -sf "$SSH_AUTH_SOCK" "$ssh_auth_sock_should_be";
        export SSH_AUTH_SOCK="$ssh_auth_sock_should_be";
	return;
    fi

    # https://gist.github.com/martijnvermaat/8070533
    if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
        ln -sf "$SSH_AUTH_SOCK" "$ssh_auth_sock_should_be";
    fi
    export SSH_AUTH_SOCK="$ssh_auth_sock_should_be";
}

function _sshutils_reset_ssh_auth() {
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock;
}
