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

# Use `ag` for fzf to ignore .gitignore files
export FZF_DEFAULT_COMMAND='ag -l --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND='ag -l --hidden --ignore .git -g ""'
export FZF_ALT_C_COMMAND='ag -l --hidden --ignore .git -g ""'

# Batch delete git branches
gitbatchd() {
  git branch | grep $1
  select yn in "Continue" "Abort"; do
    case $yn in
      Continue )
        git branch | grep $1 | xargs git branch -D
        break
        ;;
      Abort )
        echo "Aborting"
        break
        ;;
    esac
  done
}

# Copy common strings to clipboard
cb() {
  select choice in "prod" "staging"; do
    case $choice in
      prod )
        echo "6e03fa06-101c-11ec-9081-bf993a04dadc" | pbcopy
        break
        ;;
      staging )
        echo "b8a9a0ce-1715-11ec-9047-ab48de6270b0" | pbcopy
        break
        ;;
    esac
  done
}

gch() {
 git switch “$(git branch — all | fzf| tr -d ‘[:space:]’)”
}

# Pretty print a json in the clipboard and copy the new result
pp() {
  pbpaste | jq | pbcopy
}
