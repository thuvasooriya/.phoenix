pact() {
  venv_path=".venv/bin/activate"
  if [ "$#" -ne 0 ]; then
    venv_path="$1/bin/activate"
    echo "activating $venv_path"
  fi
  if [ -f "$venv_path" ]; then
    source "$venv_path"
    echo "activating $venv_path"
  else
    echo "venv not found at $venv_path"
  fi
}

pen() {
  venv_path=".venv"
  if [ "$#" -ne 0 ]; then
    venv_path="$1"
    echo "creating and activating at $1"
  fi

  python -m venv "$venv_path"
  source "$venv_path/bin/activate"
}

gig() {
  curl -sL "https://www.toptal.com/developers/gitignore/api/$1"
}

source $HOME/.phoenix/config/zsh/zsh-vi-mode.zsh
