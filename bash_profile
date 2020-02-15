if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

export PS1="\[$(tput bold)\]\[$(tput setaf 4)\]\[$(tput setaf 5)\]\W\[$(tput bold)\]\[$(tput setaf 4)\] ❯ \[$(tput sgr0)\]"

# Aliases {{{
alias code=codium
alias ls="exa"
alias zf='z --pipe="fzf"'
alias p='rg --files | fzf'
# }}}

### Added by the Heroku Toolbelt
export PATH="/usr/local/bin:/usr/local/heroku/bin:$PATH"

# {{{
# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done
# }}}

export PATH="/usr/local/sbin:$PATH"
source /Applications/Findspot.app/Contents/Resources/shell.sh
export PATH="$HOME/.yarn/bin:$PATH"

export VSCODE_TSJS=1

eval "$(direnv hook bash)"
source /Users/freemanlatif/.ghcup/env

export PATH="$HOME/.cargo/bin:$PATH"

if [ -e /Users/freemanlatif/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/freemanlatif/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

eval "$(jump shell bash)"

if command -v fzf-share >/dev/null; then
  source "$(fzf-share)/key-bindings.bash"
fi

if command -v pazi &>/dev/null; then
  eval "$(pazi init bash)"
fi
