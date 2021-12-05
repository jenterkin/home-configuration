#!/usr/bin/env bash

pecho () {
    echo -en "\033[1;34m"
    echo -n ">>> ${1}"
    echo -e "\033[0m"
}


if [[ ! $(which nix) ]]; then
    pecho "Installing Nix"
    curl -L https://nixos.org/nix/install | sh
    echo
fi

if [[ ! $(which home-manager) ]]; then
    pecho "Installing home-manager"
    export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install
    echo
fi

pecho "Ensuring flakes are enabled"

if [[ ! $(grep "experimental-features = nix-command flakes" ~/.config/nix/nix.conf) ]]; then
    nix-env -iA nixpkgs.nixFlakes
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

conf_dir="${XDG_CONFIG_HOME}"
if [[ -z "${XDG_CONFIG_HOME}" ]]; then
    conf_dir="${HOME}"/.config
fi

# Symlink home-manager config
home_manager_path="${conf_dir}"/nixpkgs/home.nix

pecho "Installing home-manager config to ${home_manager_path}"
ln -s "${script_dir}"/home.nix "${home_manager_path}" &> /dev/null

# Install home-manager if not found
if [[ ! $(which home-manager) ]]; then
    echo hello
fi

pecho "Applying home-manager config"
home-manager switch
