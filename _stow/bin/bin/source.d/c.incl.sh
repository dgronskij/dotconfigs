#!/bin/bash

# this is a way to navigate fast through consecutive `cd` calls with fzf assist
# usefull in huge monorepo
# NOTE: better to integrated into native `cd` completion

c() {
    # -C for always colorize
    local tree_cmd="tree -C -L 1 --dirsfirst {}"

    # local scheme=history
    local scheme=path
    # local scheme=default

    while true ; do
        bn="$(
            cat \
                <(find . -maxdepth 1 -mindepth 1 -type d) \
                <(echo ".._STOP")  `#this becomes defualt if there are no alternatives` \
                <(echo "../") `#this goes last so that it doesn't become default` \
            | fzf \
                --height=20 \
                --header="$PWD" \
                --exit-0 \
                --scheme=$scheme  \
                --history=$HOME/.c.fzf.history \
                --preview="$tree_cmd" \
                --no-sort \
                --layout=reverse
            )"
        if [[ "$bn" == ".._STOP" ]] ; then
            break
        fi
        if [[ -z "$bn" ]] ; then
            break
        fi

        cd "$bn"
    done
}
