if [[ -z $(command -v nvm) ]]; then
    return;
fi

if [[ ${RPROMPT#*__nvm_version_prompt} != $RPROMPT ]]; then
    return;
fi

__nvm_version_prompt() {
    local nvm_version
    nvm_version=$(nvm current)
    if [[ $nvm_version != "none" ]]; then
        echo -n "%{${fg_bold[white]}%}(nvm: %{${fg[green]}%}$nvm_version%{${fg_bold[white]}%})%{${reset_color}%}"
    fi
}


RPROMPT="\$(__nvm_version_prompt) $RPROMPT"

