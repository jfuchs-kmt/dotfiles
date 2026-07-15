# dotfiles

Minimalistic dotfiles for tools that are commonly available on HPC systems, servers or just a local machine.

## Installation
### Stow
Using stow, the dotfiles can be installed on the system of choice by executing the install script:
```
./install.sh
```
Stow will create symlinks in the user's home directory pointing to the dotfiles in this repository. If a dotfile already exists in the home directory, it will be skipped by the script.

### Manual Copying

Since these dotfiles are quite trivial, it is also easily possible to copy them to the home directory manually. Be careful not to override existing files.
