# zmodload zsh/zprof
#####################
# ZINIT             #
#####################
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p $HOME/.zinit
    # command git clone git@github.com:zdharma-continuum/zinit.git $HOME/.zinit/bin && \
    command git clone https://github.com/zdharma-continuum/zinit.git $HOME/.zinit/bin && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%F" || \
        print -P "%F{160}▓▒░ The clone has failed.%F"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

#####################
# PLUGINS           #
#####################
# SSH-AGENT
# zinit light bobsoppe/zsh-ssh-agent
 ##AUTOSUGGESTIONS, TRIGGER PRECMD HOOK UPON LOAD
#ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
#zinit ice wait"0a" lucid atload"_zsh_autosuggest_start"
#zinit light zsh-users/zsh-autosuggestions
# ENHANCD
zinit ice wait"0b" lucid
zinit light b4b4r07/enhancd
export ENHANCD_FILTER=fzf:fzy:peco
# HISTORY SUBSTRING SEARCHING
zinit ice wait"0b" lucid atload'bindkey "$terminfo[kcuu1]" history-substring-search-up; bindkey "$terminfo[kcud1]" history-substring-search-down'
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# TAB COMPLETIONS
zinit ice wait"0b" lucid blockf
zinit light zsh-users/zsh-completions
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '-- %d --'
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:complete:*:options' sort false
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'eza -1 --color=always ${~ctxt[hpre]}$in'
### FZF
## TODO TO INSTALL
#zinit ice lucid wait'0b' from"gh-r" as"program"
#zinit light junegunn/fzf
### FZF BYNARY AND TMUX HELPER SCRIPT
#zinit ice lucid wait'0c' as"command" pick"bin/fzf-tmux"
#zinit light junegunn/fzf
# BIND MULTIPLE WIDGETS USING FZF
# TODO for macos key-bindings.zsh needs to be modified to delete the condition for zmodload -u zsh/parameters p:{commands,history} in .zinit/plugins/junegunn---fzf_completions/shell/key-bindings.zsh
zinit ice lucid wait'0c' multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" pick"/dev/null"
zinit light junegunn/fzf
## FZF-TAB
zinit ice wait"1" lucid
zinit light Aloxaf/fzf-tab
# SYNTAX HIGHLIGHTING
zinit ice wait"0c" lucid atinit"zpcompinit;zpcdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting
# EXA
# # TODO TO INSTALL
#zinit ice wait"2" lucid from"gh-r" as"program" mv"exa* -> exa"
#zinit light ogham/exa
#zinit ice wait blockf atpull'zinit creinstall -q .'
# BAT
# TODO TO INSTALL
#zinit ice from"gh-r" as"program" mv"bat* -> bat" pick"bat/bat" atload"alias cat=bat"
#zinit light sharkdp/bat
# BAT-EXTRAS
zinit ice wait"1" as"program" pick"src/batgrep.sh" lucid
zinit ice wait"1" as"program" pick"src/batdiff.sh" lucid
zinit light eth-p/bat-extras
alias cat=bat
alias rg=batgrep.sh
alias bd=batdiff.sh
alias man=batman.sh
# RIPGREP
# # TODO TO INSTALL
#zinit ice from"gh-r" as"program" mv"ripgrep* -> ripgrep" pick"ripgrep/rg"
#zinit light BurntSushi/ripgrep
# FORGIT
# ga - git add
# glo - git log
# gd - git diff
# zinit ice wait lucid
# zinit load 'wfxr/forgit'
# FD
# # TODO TO INSTALL
#zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
#zinit light sharkdp/fd
# ZSH MANYDOTS MAGIC
# zinit autoload'#manydots-magic' for knu/zsh-manydots-magic
# GIT-FLOW
# zinit light petervanderdoes/git-flow-completion
## GIT-HUBFLOW
#zinit ice wait"2" lucid from"gh-r" as"program" mv"exa* -> exa"
#zinit light mborsuk/hubflow
# DIRENV auto load .envrc
# zinit from"gh-r" as"program" mv"direnv* -> direnv" \
#     atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
#     pick"direnv" src="zhook.zsh" for \
#         direnv/direnv

#####################
# HISTORY           #
#####################
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=290000
SAVEHIST=$HISTSIZE

#####################
# SETOPT            #
#####################
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_all_dups   # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
setopt always_to_end          # cursor moved to the end in full completion
setopt hash_list_all          # hash everything before completion
# setopt completealiases        # complete alisases
setopt always_to_end          # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word       # allow completion from within a word/phrase
setopt nocorrect                # spelling correction for commands
setopt list_ambiguous         # complete as much of a completion until it gets ambiguous.
setopt nolisttypes
setopt listpacked
setopt automenu
setopt vi

#####################
# ENV VARIABLE      #
#####################
export EDITOR='nvim'
export VISUAL=$EDITOR
export PAGER='less'
export SHELL='/bin/zsh'
#export LANG='en_GB.UTF-8'
#export LC_ALL='en_GB.UTF-8'
export BAT_THEME="ansi"
# export TZ_LIST="Europe/Warsaw,Warsaw - Home;Asia/Hong_Kong,Bali;US/Central,Colorado - Denver"
export TZ_LIST="US/Mountain,Denver;US/Central,Houston"

#PATH="/usr/local/bin:/usr/local/sbin/:$PATH"
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/scripts
#path+=('/usr/local/bin')
#path+=('$HOME/.local/bin')
#path+=('$HOME/.cargo/bin')
#export PATH

#####################
# COLORING          #
#####################
# autoload colors && colors

#####################
# ALIASES           #
#####################
#source $HOME/.zsh_aliases
alias ..="cd .."
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias pskill="ps aux  |  grep -i csp_build  |  awk '{print $2}'  |  xargs sudo kill -9"
alias ram="ps aux | awk '{print $2, $4, $11}' | sort -k2rn | head -n 20"
alias myip="curl http://ipecho.net/plain; echo"
alias ls="eza --git --icons --group-directories-first --time-style=long-iso --group"
alias myconfig='/usr/bin/git --git-dir=$HOME/.myconfig/ --work-tree=$HOME'
alias -- -='cd -'
alias cht="cht.sh"

alias srconfig='source ~/.zshrc'
alias senv='python --version; which pip; source .venv/bin/activate; python --version; which pip'
alias eenv='eval $(cat .env)'
alias weather='curl wttr.in'
alias clp="greenclip print | sed '/^$/d' | fzf -e | xargs -r -d'\n' -I '{}' greenclip print '{}'"
# alias cleanup="yay -Rsn $(yay -Qdtq)"
# alias pkginstall="yay -S $(awk '{print $1}' ~/packages.info) --needed"
alias godoro='pomodoro $1 && dunstify "Pomodoro finish time!!!" -u critical -t 9999999'
alias caps='/usr/bin/setxkbmap -option "ctrl:nocaps"'
alias muteoff="brightnessctl -d 'platform::mute' set 0"
# alias src="export $(cat .env | xargs)"
#alias nvim=/usr/local/bin/nvim
#alias snvim=/usr/bin/nvim
# alias vi=/usr/bin/nvim
# alias vi=$HOME/.local/bin/nnvim
# alias vi=$HOME/.local/bin/nvim
alias mpcloud="rclone mount pcloud:/ $HOME/pCloudDrive"
alias run=./run
alias connect="protonvpn-cli connect -f"
alias disconnect="protonvpn-cli disconnect"
alias hm="home-manager"

alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

alias tf="terraform"
alias localaws='docker run -d -e "SERVICES=s3,dynamodb" -p 4566-4599:4566-4599 localstack/localstack:0.12.6'
alias completeaws="complete -C '/usr/bin/aws_completer' aws"
alias ghce="gh copilot explain"
alias ghcs="gh copilot suggest"

alias oc="opencode"
alias fabric="fabric-ai"
alias todo="todoist-rs"

#alias poetry=$HOME/.poetry/bin/poetry

#####################
# FUNCTIONS         #
#####################

# Automatic ls when changing directory
# removed --classify
chpwd() eza --git --icons --group-directories-first --time-style=long-iso --group

# run all bats tests for exercism
ba() {
    BATS_RUN_SKIPPED=true command bats *.bats
}

# decode JWT token and return header and payload
decode() {
    jq -R 'split(".") | select(length > 0) | .[0],.[1] | @base64d | fromjson' <<< "$1"
}

# Override fzf-history-widget to use fc instead of $history array
# (share_history breaks $history in subshells)
zinit ice lucid wait'0c' multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" pick"/dev/null" \
  atload'fzf-history-widget() {
    local selected
    setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases noglob no_ksharrays extendedglob 2> /dev/null
    selected="$(fc -rl 1 | awk '\''{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }'\'' |
      FZF_DEFAULT_OPTS="$(__fzf_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort --wrap-sign '\''\t↳ '\'' --highlight-line ${FZF_CTRL_R_OPTS-} --query=${(qqq)LBUFFER}")" \
      FZF_DEFAULT_OPTS_FILE='\'''\'' $(__fzfcmd))"
    local ret=$?
    if [[ -n "$selected" ]]; then
      local num=$(awk '\''{print $1}'\'' <<< "$selected")
      if [[ -n "$num" ]]; then
        zle vi-fetch-history -n $num
      fi
    fi
    zle reset-prompt
    return $ret
  }'
zinit light junegunn/fzf

#####################
# DOCKER FUNC      #
#####################
alias drc='docker-compose'
alias dre='docker exec -it'

# docker-ip () { docker inspect "$@" | grep "IPAddress\": \"1" | grep -o "[0-9\.]*"| uniq | head -1; }
# logs () { docker logs -f --tail 100  "$@" ; }
# b () { docker exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`"  -it "$@" bash; }
#
# drsh () { docker exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`"  -it "$@" bash; }
# drec () { docker run --rm -it --entrypoint bash "$@"; }
#
# # Functions
# # remove images matching pattern
# drirm () {
#   images=$(docker image ls -f "reference=$1*" -q)
#   if [[ -z "$images" ]]; then
#     echo "drirm: ❌ No images matching: \"$1*\"; Aborting."
#   else
#     count=$(echo $images | sed '/^\s*$/d' | wc -l | xargs)
#     echo "drirm: ℹ️  Found: $count images to be removed."
#     docker image rm $(docker image ls -f "reference=$1*" -q) --force
#     # docker image rm $images --force
#     echo "drirm: ✅ Removed: $count images."
#   fi
# }
# # remove networks matching pattern
# drnrm () {
#   networks=$(docker network ls -f "name=$1*" -q)
#   if [[ -z "$networks" ]]; then
#     echo "drnrm: ❌ No networks matching: \"$1*\"; Aborting."
#   else
#     count=$(echo $networks | sed '/^\s*$/d' | wc -l | xargs)
#     echo "drnrm: ℹ️  Found: $count networks to be removed."
#     docker network rm $(docker network ls -f "name=$1*" -q)
#     # docker network rm $networks
#     echo "drnrm: ✅ Removed: $count networks."
#   fi
# }
# # remove containers matching pattern
# drcrm () {
#   containers=$(docker ps -aqf "name=$1*" -q)
#   if [[ -z "$containers" ]]; then
#     echo "drcrm: ❌ No containers matching: \"$1*\"; Aborting."
#   else
#     count=$(echo $containers | sed '/^\s*$/d' | wc -l | xargs)
#     echo "drcrm: ℹ️  Found: $count containers to be removed."
#     docker container rm $(docker ps -aqf "name=$1*" -q) --force
#     # docker container rm $containers --force
#     echo "drcrm: ✅ Removed: $count containers."
#   fi
# }
# # remove volumes matching pattern
# drvrm () {
#   volumes=$(docker volume ls -f "name=$1*" -q)
#   if [[ -z "$volumes" ]]; then
#     echo "drvrm: ❌ No volumes matching: \"$1*\"; Aborting."
#   else
#     count=$(echo $volumes | sed '/^\s*$/d' | wc -l | xargs)
#     echo "drvrm: ℹ️  Found: $count volumes to be removed."
#     docker volume rm $(docker volume ls -f "name=$1*" -q) --force
#     # docker volume rm $volumes --force
#     echo "drvrm: ✅ Removed: $count volumes."
#   fi
# }
# # nuke images, containers and volumes matching pattern
# drnuke () {
#   drnrm $1;
#   drirm $1;
#   drcrm $1;
#   drvrm $1;
# }

#####################
# Toggl CLI         #
#####################
# alias tg=toggl
#
# tgs() {
#     project_name=$2
#     toggl start $1 --project-id $(toggl projects | awk -v var=$project_name '$2 == var { print $1 }')
# }

########################
# K8s helpers          #
#######################
export KUBECONFIG=~/.kube/config
export KUBECONFIG=$KUBECONFIG:~/.kube/pi-config

# Source: https://wkontenerach.pl/jak-zdac-ckad-certified-kubernetes-application-developer/
export dry=" -o yaml --dry-run=client -o yaml"
export now="--force --grace-period=0"

# kubectl create deployment my-dep --image=busybox -o yaml --dry-run -o yaml > deploy-example.yaml
# kubectl explain

alias bb="k run busybox --image=busybox:latest --restart=Never --rm -it --command -- "

alias k="kubectl"
alias kc="kubecolor"
alias mk="minikube kubectl --"
alias ka="kubectl apply -f"
alias kcl="kubectl config get-contexts"
alias kns="kubectl config set-context --current --namespace"

function kctx() {
    found=0
    for c in $(kubectl config get-contexts --no-headers -o name); do
        if [[ $c == $1 ]]; then
            found=1
        fi
    done
    if [[ $found == 0 ]]; then
        echo "Context $1 not found"
        return 1
    fi
    echo "Switching to context $1 and setting up aliases"

    BASE="kubectl --context=$1"

    alias k="$BASE"
    alias kg="$BASE get"
    alias ke="$BASE edit"
    alias kgp="$BASE get pod"
    alias kde="$BASE describe"
}

#####################
# YAZI              #
#####################

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

#####################
# FABRIC            #
#####################

# # Loop through all files in the ~/.config/fabric/patterns directory
# for pattern_file in $HOME/.config/fabric/patterns/*; do
#     # Get the base name of the file (i.e., remove the directory path)
#     pattern_name="$(basename "$pattern_file")"
#     alias_name="${FABRIC_ALIAS_PREFIX:-}${pattern_name}"
#
#     # Create an alias in the form: alias pattern_name="fabric --pattern pattern_name"
#     alias_command="alias $alias_name='fabric --pattern $pattern_name'"
#
#     # Evaluate the alias command to add it to the current shell
#     eval "$alias_command"
# done

yt() {
    if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
        echo "Usage: yt [-t | --timestamps] youtube-link"
        echo "Use the '-t' flag to get the transcript with timestamps."
        return 1
    fi

    transcript_flag="--transcript"
    if [ "$1" = "-t" ] || [ "$1" = "--timestamps" ]; then
        transcript_flag="--transcript-with-timestamps"
        shift
    fi
    local video_link="$1"
    fabric -y "$video_link" $transcript_flag
}

#####################
# FZF SETTINGS      #
#####################
#--info=inline
#--no-sort
export FZF_DEFAULT_OPTS="
--ansi
--layout=reverse
--height=50%
--multi
--preview-window=right:60%
--preview-window=sharp
--preview-window=cycle
--preview '([[ -f {} ]] && (bat --force-colorization --style=changes --paging=never --theme=ansi --line-range :500 {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--prompt='λ -> '
--pointer='|>'
--marker='✓'
--bind 'ctrl-s:select-all'
--bind 'ctrl-e:execute(nvim {} < /dev/tty > /dev/tty 2>&1)' > selected
--bind 'ctrl-v:execute(nvim {+})'"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden -g "!{.git/*,.tox/*,venv/*,.venv/*,.pyenv/*,*.pyi,*.pyc,__pycache__/*,.cache/*,.mypy_cache/*}" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

#####################
# GO SETTINGS       #
#####################
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin
#export GOPATH=$GOPATH:$HOME/code

#####################
# Wayland SETTINGS  #
#####################

# NOTE: this should be set only for hyprland
# export WAYLAND_DISPLAY=wayland-1
# alias hyprctl="hyprctl --instance 0"

#####################
# Starship Prompt   #
#####################

eval "$(starship init zsh)"

# Necessary for AWS autocompletion
# autoload bashcompinit && bashcompinit
# autoload -Uz compinit && compinit
# compinit
#
# eval "$(complete -C '/usr/bin/aws_completer' aws)"
# eval "$(bw completion --shell zsh); compdef _bw bw;"

eval "$(mise activate zsh)"

# opencode
export PATH=/home/mgajewskik/.opencode/bin:$PATH
