#!/bin/bash

PACKAGES="tmux vim git"

for package in $PACKAGES; do
    stow $package --target=$HOME -Rv
done
