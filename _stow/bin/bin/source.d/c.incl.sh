#!/bin/bash

# this is a way to navigate fast through consecutive `cd` calls with fzf assist
# usefull in huge monorepo
# NOTE: better to integrated into native `cd` completion

c() {
    # -C for always colorize
    local tree_cmd="tree -C -L 1 --dirsfirst {}"
    while true ; do
        bn="$(
            find . -maxdepth 1 -mindepth 1 -type d \
            | fzf \
                --height=20 \
                --header="$PWD" \
                --exit-0 \
                --scheme=history  \
                --history=$HOME/.c.fzf.history \
                --preview="$tree_cmd"
            )"
        if [[ -z "$bn" ]] ; then
            break
        fi

        cd "$bn"
    done
}
