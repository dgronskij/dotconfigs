#!/bin/bash

# TODO: environment variable to set link location

# this function should be called in ~/.profile
function _sshutils_relink_ssh_auth() {
    # https://gist.github.com/martijnvermaat/8070533
    if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock;
    fi
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock;
}

function _sshutils_reset_ssh_auth() {
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock;
}
