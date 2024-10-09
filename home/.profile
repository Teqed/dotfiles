#!/bin/sh
XDG_LOCAL_HOME="$HOME/.local";                              export XDG_LOCAL_HOME
XDG_BIN_HOME="$XDG_LOCAL_HOME/bin";                         export XDG_BIN_HOME
PATH="$XDG_BIN_HOME:$PATH";                                 export PATH
LD_LIBRARY_PATH="$XDG_LOCAL_HOME/lib";                      export LD_LIBRARY_PATH
LIBPATH="$XDG_LOCAL_HOME/lib";                              export LIBPATH
XDG_DATA_HOME="$XDG_LOCAL_HOME/share";                      export XDG_DATA_HOME
XDG_DATA_DIRS="$XDG_DATA_HOME";                             export XDG_DATA_DIRS
TERMINFO="$XDG_DATA_HOME/terminfo";                         export TERMINFO
TERMINFO_DIRS="$XDG_DATA_HOME/terminfo";                    export TERMINFO_DIRS
XDG_CONFIG_HOME="$HOME/.config";                            export XDG_CONFIG_HOME
XDG_CONFIG_DIRS="$XDG_CONFIG_HOME";                         export XDG_CONFIG_DIRS
INPUTRC="$XDG_CONFIG_HOME/readline/inputrc";                export INPUTRC
XDG_STATE_HOME="$XDG_LOCAL_HOME/state";                     export XDG_STATE_HOME
XDG_CACHE_HOME="$HOME/.cache";                              export XDG_CACHE_HOME
HISTFILE="$XDG_STATE_HOME/history/histfile";                export HISTFILE
HISTSIZE=15000;                                             export HISTSIZE
HISTFILESIZE=32768;                                         export HISTFILESIZE
HISTCONTROL="$HISTCONTROL"${HISTCONTROL+,}ignoreboth;       export HISTCONTROL
if [ "`uname -s`" = "OS400" ]; then
    PATH="$XDG_BIN_HOME:$XDG_LOCAL_HOME/QOpenSys/pkgs/bin:/QOpenSys/pkgs/bin:$PATH" ; export PATH
    LD_LIBRARY_PATH="$XDG_LOCAL_HOME/QOpenSys/pkgs/lib" ;   export LD_LIBRARY_PATH
    LIBPATH="$XDG_LOCAL_HOME/QOpenSys/pkgs/lib" ;           export LIBPATH
    TERMINFO="$XDG_LOCAL_HOME/QOpenSys/pkgs/share/terminfo" ; export TERMINFO
    TERMINFO_DIRS="$XDG_LOCAL_HOME/QOpenSys/pkgs/share/terminfo:$TERMINFO_DIRS" ; export TERMINFO_DIRS
    JAVA_HOME="/QOpenSys/QIBM/ProdData/JavaVM/jdk80/64bit" ; export JAVA_HOME
    QIBM_MULTI_THREADED=Y ;                                 export QIBM_MULTI_THREADED
fi
__SH_INIT="1";                                              export __SH_INIT
__startshell() {
    if [ ! -t 0 ] || [ -z "$TERM" ] || [ "$TERM" = "dumb" ] || [ -n "$BASH_VERSION" ]; then return ; fi ;
    exec "$XDG_LOCAL_HOME"/QOpenSys/pkgs/bin/bash -l
} ; __startshell
