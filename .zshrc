# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/nguyennk/.oh-my-zsh"

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=1
# load zgen
source "${HOME}/.zgen/zgen.zsh"
# if the init script doesn't exist
if ! zgen saved; then

    # specify plugins here
    zgen oh-my-zsh
    #zgen oh-my-zsh plugins/git
    #zgen oh-my-zsh plugins/tmux
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-history-substring-search

    # Load more completion files for zsh from the zsh-lovers github repo.
    zgen load zsh-users/zsh-completions src

    zgen load zsh-users/zsh-autosuggestions
    zgen load romkatv/powerlevel10k powerlevel10k

    zgen load mafredri/zsh-async
    zgen load docker/cli contrib/completion/zsh

    # generate the init script from plugins above
    zgen save
fi

# User configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$HOME/.pyenv/bin:$HOME/.local/bin/:$PATH"
function load_pyenv() {
  if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
  fi
}
export WORKON_HOME=$HOME/Envs
export VIRTUALENVWRAPPER_SCRIPT=$HOME/.local/bin/virtualenvwrapper.sh
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
#eval "$(direnv hook zsh)"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias tmux="tmux -2"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PROMPT_COMMAND='echo -e -n "\x1b[\x35 q"'
precmd() { eval "$PROMPT_COMMAND" }

CPU=$(uname -p)
export ANDROID_HOME=$HOME/Android
export JAVA_HOME=$HOME/.sdkman/candidates/java/current
export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:/usr/local/go/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$JAVA_HOME/bin:$HOME/go/bin:$HOME/.local/share/solana/install/active_release/bin:$HOME/apache-maven-3.8.5/bin:$PATH"
#
# Prioritize /opt/homebrew when using arm64
if [[ "$CPU" == "arm" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

export GRADLE_USER_HOME="$HOME/.gradle"
export KEYTIMEOUT=1
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# less syntax highlight
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

export NVM_DIR="$HOME/.nvm"
export GPG_TTY=$(tty)
function load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}
function load() {
  #load_nvm
  #load_pyenv
}

# Initialize worker
# async_start_worker worker -n
# async_register_callback worker load
# async_job worker sleep 0.01

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
source <(kubectl completion zsh)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/nguyennk92/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/nguyennk92/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/nguyennk92/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/nguyennk92/google-cloud-sdk/completion.zsh.inc'; fi

alias cbtd="cbt -project=dev-krystal-wallet -instance=chaindata-bigtable -creds=$HOME/.secret/dataflow.json"
alias cbtp="cbt -project=production-krystal-wallet -instance=chaindata-bigtable -creds=$HOME/.secret/dataflow_prod.json"

. "$HOME/.local/bin/env"
