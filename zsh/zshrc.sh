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

gch() {
 git switch “$(git branch — all | fzf| tr -d ‘[:space:]’)”
}

