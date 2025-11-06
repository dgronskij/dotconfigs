echo "this is .zprofile" >&2

# https://superuser.com/questions/187639/zsh-not-hitting-profile#187673
emulate sh
. ~/.profile
emulate zsh
