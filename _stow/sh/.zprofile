echo "this is .zprofile"

# https://superuser.com/questions/187639/zsh-not-hitting-profile#187673
emulate sh
. ~/.profile
emulate zsh
