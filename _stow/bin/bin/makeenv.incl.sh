#!/bin/bash

function makeenv() {
    version=$(pyenv versions --bare | fzf | grep -oP '\d+(\.\d+)*')
    venv_path="venv${version}"
    PYENV_VERSION=$( echo $version )  python -m venv "$venv_path" && source "$venv_path/bin/activate"
}
