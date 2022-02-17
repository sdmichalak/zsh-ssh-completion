#!/usr/bin/env zsh

function sources() {
    find ~/.ssh/config
    find ~/.ssh/config.d/
}

h=()

if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(sources)"}:#Host *}#Host }:#*[*?]*})
fi

if [[ -r ~/.ssh/known_hosts ]]; then
  h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
fi

if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:slogin:*' hosts $h
fi
