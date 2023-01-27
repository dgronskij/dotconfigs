# https://superuser.com/questions/187639/zsh-not-hitting-profile#187673

emulate sh
. ~/.profile
emulate zsh


# >>> coursier install directory >>>
export PATH="$PATH:/home/d.gronsky/.local/share/coursier/bin"
# <<< coursier install directory <<<
