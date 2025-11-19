# COPIED FROM https://github.com/gokcehan/lf/blob/master/etc/lfcd.sh


# Change working dir in shell to last dir in lf on exit (adapted from ranger).
#
# You need to either copy the content of this file to your shell rc file
# (e.g. ~/.bashrc) or source this file directly:
#
#     LFCD="/path/to/lfcd.sh"
#     if [ -f "$LFCD" ]; then
#         source "$LFCD"
#     fi
#
# You may also like to assign a key (Ctrl-O) to this command:
#
#     bind '"\C-o":"lfcd\C-m"'  # bash
#     bindkey -s '^o' 'lfcd\n'  # zsh
#

lfcd () {
    # `command` is needed in case `lfcd` is aliased to `lf`
    cd "$(command lf -print-last-dir "$@")"
}

lfcd2() {
    tmpfile=$(mktemp --suffix .lfcd)
    # Start lf with an environment variable pointing to the temp file
    LFCD_FILE="$tmpfile" command lf "$@"
    if [ -f "$tmpfile" ]; then
        target=$(cat "$tmpfile")
        rm -f "$tmpfile"
        # Only cd if the file is not empty
        [ -n "$target" ] && cd "$target"
    fi
}
