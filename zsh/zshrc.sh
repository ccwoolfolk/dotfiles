export TERM="xterm-256color"

# Can remove these if using oh-my-zsh
alias ..="cd .."
alias ...="cd ..."

# Use node version specified in local directory
loadnvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")");

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

alias nvmuse="loadnvmrc"

# Custom cd
c() {
	cd $1;
	ls;
	loadnvmrc;
}
alias cd="c"

# Side-by-side diff
# Setup: `brew install ydiff`
alias d="ydiff -s"

# Run dev server
alias lw="REACT_APP_ENV=production HTTPS=true npm start"
alias cw="ENV=production npm start"

# Configure completions per docs.brew.sh/Shell-Completion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# brew cask install font-firacode-nerd-font-mono
# then select font in terminal profile (Fura Code...)
POWERLEVEL9K_MODE='nerdfont-complete'
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_COLOR_SCHEME='light'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_STATUS_VERBOSE=false

# pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# virtualenvwrapper
export WORKON_HOME=~/envs

# Install Ruby Gems to ~/gems
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH
