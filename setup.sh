#!/usr/bin/env bash

pecho () {
    echo -en "\033[1;34m"
    echo -n ">>> ${1}"
    echo -e "\033[0m"
}


# TODO: automate dep installation
# Check requirements
missing_deps=0
if [[ ! $(which nix) ]]; then
    pecho "Nix is not installed. Please install it and run this script again:"
    pecho "    curl -L https://nixos.org/nix/install | sh"
    echo

    missing_deps=1
fi

if [[ ! $(which home-manager) ]]; then
    pecho "home-manager is not installed. Please install it and run this script again:"
    pecho "    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager"
    pecho "    nix-channel --update"
    pecho "    nix-shell '<home-manager>' -A install"
    echo

    missing_deps=1
fi

if [[ missing_deps -eq 1 ]]; then
    exit
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
