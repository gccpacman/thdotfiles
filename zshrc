# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*~*.zwc(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/(pre|post)/*|*.zwc)
          :
          ;;
        *)
          . $config
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*~*.zwc(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# lang
export LANG='UTC-8'
export LC_ALL='en_US.UTF-8'

# oh my zsh
export ZSH="$HOME/.dotfiles/oh-my-zsh"

ZSH_THEME="robbyrussell"
# zstyle ':omz:update' mode reminder 
# zstyle ':omz:update' frequency 7
plugins=(git docker kubectl helm brew tmux vscode python mvn themes virtualenv macos tmux) 

source $ZSH/oh-my-zsh.sh

# kube promote
autoload -U colors; colors
source $HOME/.dotfiles/zsh-kubectl-prompt/kubectl.zsh
RPROMPT='%{$fg[blue]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/r341h/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)