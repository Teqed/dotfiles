#!/usr/bin/env bash
if [[ -z "${__SH_INIT}" ]] ; then source "${HOME}/.profile" ; fi # Source the .profile, which sets environment variables first
# If interactive
case $- in *i* )
    ### Environment
    export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
    export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"
    export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
    export SCREENRC="$XDG_CONFIG_HOME/screenrc"
    export WGETRC="$XDG_CONFIG_HOME/wgetrc"
    export VIMINIT=":so $XDG_CONFIG_HOME/vim/.vimrc"
    export GVIMINIT=":so $XDG_CONFIG_HOME/vim/.vimrc"
    export MYSQL_HISTFILE="$XDG_STATE_HOME/history/mysql_history"
    export SQLITE_HISTORY="$XDG_STATE_HOME/history/sqlite_history"
    export ANSIBLE_HOME="$XDG_DATA_HOME/ansible"
    export PIP_LOG_FILE="$XDG_CACHE_HOME/pip/pip.log"
    export XDG_USER_DIRS="$XDG_LOCAL_HOME/user-dirs"
    ln -sfn "$XDG_USER_DIRS" "$HOME/_" 2>/dev/nul
    export XDG_DESKTOP_DIR="$XDG_USER_DIRS/Desktop"
    export XDG_DOWNLOAD_DIR="$XDG_USER_DIRS/Downloads"
    export XDG_TEMPLATES_DIR="$XDG_USER_DIRS/Templates"
    export XDG_PUBLICSHARE_DIR="$XDG_USER_DIRS/Public"
    export XDG_DOCUMENTS_DIR="$XDG_USER_DIRS/Documents"
    export XDG_MUSIC_DIR="$XDG_USER_DIRS/Music"
    export XDG_PICTURES_DIR="$XDG_USER_DIRS/Pictures"
    export XDG_VIDEOS_DIR="$XDG_USER_DIRS/Videos"
    export XDG_MISC_DIR="$XDG_USER_DIRS/Misc"
    export XDG_REPOS_DIR="$XDG_USER_DIRS/Repos"
    export XDG_SCREENSHOTS_DIR="$XDG_USER_DIRS/Pictures/Screenshots"
    export XDG_OPT_HOME="$XDG_LOCAL_HOME/opt"
    export EDITOR="nano"
    export VISUAL="nano"
    export PAGER="less"
    export LESS="-RF"
    # Ignore some controlling instructions
    # HISTIGNORE is a colon-delimited list of patterns which should be excluded.
    # The '&' is a special pattern which suppresses duplicate entries.
    export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
    export HISTFILE="$XDG_STATE_HOME/history/bash_history"
    ### shopts
    shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
    shopt -s globstar # If set, the pattern "**" used in a pathname expansion context will match all files and zero or more directories and subdirectories.
    shopt -s cdspell # If set, minor errors in the spelling of a directory component in a cd command will be corrected. The errors checked for are transposed characters, a missing character, and a character too many.
    shopt -s dirspell # If set, Bash attempts spelling correction on directory names during word completion if the directory name initially supplied does not exist.
    shopt -s dotglob # If set, Bash includes filenames beginning with a ‘.’ in the results of filename expansion.
    shopt -s extglob # If set, the extended pattern matching features are enabled.
    shopt -s nocaseglob # Use case-insensitive filename globbing
    shopt -s histappend # Make bash append rather than overwrite the history on disk
    umask 077 # Sets a more restrictive umask: neither group nor others have any perms.
    export CLICOLOR=1
    export LESS_TERMCAP_mb=$'\e[01;31m'   # begin bold
    export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin blink
    export LESS_TERMCAP_me='\e[0m'            # reset bold/blink
    export LESS_TERMCAP_se='\e[0m'            # reset reverse video
    export LESS_TERMCAP_so=$'\e[38;5;246m' # begin reverse video
    export LESS_TERMCAP_ue='\e[0m'            # reset underline
    export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline
    export GREP_COLORS="ms=1;32:mc=1;32:ln=33" # (new) Matching text in Selected line = green, line numbers dark yellow
    # colored GCC warnings and errors
    export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"
    error()   { local opts ; [[ $1 = "-n" ]] && { opts=$1 ; shift ; } ; echo "$opts" "[1m[1;31m$*[0m" ; }
    warning() { local opts ; [[ $1 = "-n" ]] && { opts=$1 ; shift ; } ; echo "$opts" "[1m[1;35m$*[0m" ; }
    info()    { local opts ; [[ $1 = "-n" ]] && { opts=$1 ; shift ; } ; echo "$opts" "[1m[1;36m$*[0m" ; }
    verbose() { local opts ; [[ $1 = "-n" ]] && { opts=$1 ; shift ; } ; echo "$opts" "[1m[1;32m$*[0m" ; }
    debug()   { local opts ; [[ $1 = "-n" ]] && { opts=$1 ; shift ; } ; echo "$opts" "[1m[1;34m$*[0m" ; }
    highlight() { local opts ; [[ $1 = "-n" ]] && { opts=$1 ; shift ; } ; echo "$opts" "[1m[1;37m$*[0m" ; }
    danger()    { local opts ; [[ $1 = "-n" ]] && { opts=$1 ; shift ; } ; echo "$opts" "[47m[1;5;31m$*[0m" ; }
    # Extract archives - use: extract <file>
    extract() {
        if [ -f "$1" ] ; then
            case $1 in
                *.tar.bz2)   tar xjf "$1" ;;
                *.tar.gz)    tar xzf "$1" ;;
                *.bz2)       bunzip2 "$1" ;;
                *.rar)       rar x "$1" ;;
                *.gz)        gunzip "$1" ;;
                *.tar)       tar xf "$1" ;;
                *.tbz2)      tar xjf "$1" ;;
                *.tgz)       tar xzf "$1" ;;
                *.zip)       unzip "$1" ;;
                *.Z)         uncompress "$1" ;;
                *.7z)        7z x "$1" ;;
                *)           echo "'$1' cannot be extracted via extract()" ;;
            esac
        else
            echo "'$1' is not a valid file"
        fi
    }
    mkcdr() { mkdir -p "$1" && cd "$1" || return; }
    pecho() { # Print with a newline
        for arg ; do
            echo "${arg//[:;]/\n\n}" ;
        done
    }
    cheat() { # Get manpage-like help for a command (e.g. cheat wget)
        curl cheat.sh/"$1"
    }
    ttitle() { echo -n "]0;$*"; } # Set window title function
    ### Prompt
    export GIT_PS1_SHOWDIRTYSTATE=1 # Show * if repo is dirty
    _hostname=$(hostname) # Get hostname and remove www. prefix if present
    [[ $_hostname == www.* ]] && _hostname=${_hostname:4} ; [[ $_hostname == WWW.* ]] && _hostname=${_hostname:4}
    ttitle "$_hostname" # Set title to hostname now
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then debian_chroot=$(cat /etc/debian_chroot) ; fi
    __prompt_command() { # Function to generate PS1 after each command
        history -a # Append to history file
        local EXIT="$?" # Get exit code of last command
        shortpath=$(awk -F'/' '{if(NF>5) print $1"/"$2"/../"$(NF-1)"/"$(NF-0); else print $0;}' <<<"${PWD/#$HOME/\~}") # Shorten path to first and last 3 directories
        ttitle "${_hostname} ${shortpath}"
        IFS=';' read -r -sdR -p $'\E[6n' _ROW COL # Get cursor position
        [ "$COL" -ne 1 ] && echo '' # Add newline if cursor is not at 1st column
        PS1="${debian_chroot:+($debian_chroot)}\[\033[38;5;81m\]$_hostname \[\033[38;5;141m\]${shortpath}";
        if [ $EXIT != 0 ]; then PS1+=" \[\e[0;31m\]" # Add red if exit code non 0
        else PS1+=" \[\e[49;38;5;227m\]" ; fi # Add yellow if exit code 0
        PS1+="\$\[\e[0m\] " ; # Add prompt symbol and reset colors
    }
    PROMPT_COMMAND=__prompt_command
    __prompt_command # Generate PS1 for first time
    ### Aliases
    alias reload="source ~/.bash_profile" # Reload bash shortcut
    alias tn5250='tn5250 env.TERM=IBM-3477-FC' # Use 132x27 color display by default
    alias 5250='tn5250 ssl:localhost env.TERM=IBM-3477-FC' # Connect to localhost using TLS
    alias rm='rm -i' # Force interactive operation
    alias df='df -h' # Default to human readable figures
    alias du='du -h'
    if hash dircolors 2>/dev/null; then # enable color support of ls and also add handy aliases
        [ -f "$XDG_CONFIG_HOME"/dircolors/dircolors ] && eval "$(dircolors -b "$XDG_CONFIG_HOME"/dircolors/dircolors)" || eval "$(dircolors -b)"
        alias ls='ls -hF --color=auto --group-directories-first'
        alias dir='dir --color=auto'
        alias vdir='vdir --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='LC_ALL=C fgrep --color=auto'
        alias egrep='egrep --color=auto'
        alias ncdu='ncdu --color dark'
    fi
    if hash grc 2>/dev/null; then # aliases for grc(1) - Generic Colouriser
        GRC="$(which grc)" # Get the path to grc
        if tty -s && [ -n "$TERM" ] && [ "$TERM" != dumb ] && [ -n "$GRC" ]; then # If terminal is interactive and grc is available
            alias colourify='$GRC -es --colour=auto'
            alias docker="colourify docker"
            alias docker-compose='colourify docker-compose'
            alias docker-machine='colourify docker-machine'
            alias make="colourify make"
            alias g++='colourify g++'
            alias as="colourify as"
            alias gas="colourify gas"
            alias journalctl="colourify journalctl"
            alias kubectl="colourify kubectl"
            alias ld="colourify ld"
            alias head="colourify head"
            alias tail="colourify tail"
            alias semanage="colourify semanage"
            alias sockstat="colourify sockstat"
            alias whois="colourify whois"
            alias wdiff="colourify wdiff"
            alias vmstat="colourify vmstat"
            alias uptime="colourify uptime"
            alias ulimit="colourify ulimit"
            alias tune2fs="colourify tune2fs"
            alias traceroute="colourify traceroute"
            alias traceroute6="colourify traceroute6"
            alias tcpdump="colourify tcpdump"
            alias systemctl="colourify systemctl"
            alias sysctl="colourify sysctl"
            alias stat="colourify stat"
            alias ss="colourify ss"
            alias sql="colourify sql"
            alias showmount="colourify showmount"
            alias sensors="colourify sensors"
            alias semanageuser="colourify semanageuser"
            alias semanagefcontext="colourify semanagefcontext"
            alias semanageboolean="colourify semanageboolean"
            alias pv="colourify pv"
            alias ps="colourify ps"
            alias proftpd="colourify proftpd"
            alias ping2="colourify ping2"
            alias ping="colourify ping"
            alias php="colourify php"
            alias ntpdate="colourify ntpdate"
            alias nmap="colourify nmap"
            alias netstat="colourify netstat"
            alias mvn="colourify mvn"
            alias mtr="colourify mtr"
            alias mount="colourify mount"
            alias lspci="colourify lspci"
            alias lsof="colourify lsof"
            alias lsmod="colourify lsmod"
            alias lsblk="colourify lsblk"
            alias lsattr="colourify lsattr"
            alias lolcat="colourify lolcat"
            alias log="colourify log"
            alias ldap="colourify ldap"
            alias last="colourify last"
            alias iwconfig="colourify iwconfig"
            alias irclog="colourify irclog"
            alias iptables="colourify iptables"
            alias iproute="colourify iproute"
            alias ipneighbor="colourify ipneighbor"
            alias ipaddr="colourify ipaddr"
            alias ip="colourify ip"
            alias iostat_sar="colourify iostat_sar"
            alias ifconfig="colourify ifconfig"
            alias id="colourify id"
            alias getsebool="colourify getsebool"
            alias getfacl="colourify getfacl"
            alias gcc="colourify gcc"
            alias free="colourify free -h"
            alias findmnt="colourify findmnt"
            alias fdisk="colourify fdisk"
            alias esperanto="colourify esperanto"
            alias env="colourify env"
            alias du="colourify du -h"
            alias dockerversion="colourify dockerversion"
            alias dockersearch="colourify dockersearch"
            alias dockerpull="colourify dockerpull"
            alias dockerps="colourify dockerps"
            alias dockernetwork="colourify dockernetwork"
            alias docker-machinels="colourify docker-machinels"
            alias dockerinfo="colourify dockerinfo"
            alias dockerimages="colourify dockerimages"
            alias dnf="colourify dnf"
            alias dig="colourify dig"
            alias diff="colourify diff"
            alias df="colourify df -h"
            alias cvs="colourify cvs"
            alias configure="colourify ./configure"
            alias blkid="colourify blkid"
            alias ant="colourify ant"
        fi ; fi
esac