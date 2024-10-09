#!/usr/bin/env bash
if [[ -n "$BASH_VERSION" ]] || [[ "$0" == *bash ]] ; then # if running bash
    if [[ -f "$HOME/.bashrc" ]] ; then source "$HOME/.bashrc" ; fi ; fi # include .bashrc if it exists