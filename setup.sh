#!/usr/bin/env bash

pecho () {
    echo -en "\033[1;34m"
    echo -n ">>> ${1}"
    echo -e "\033[0m"
}

perror () {
    echo -en "\033[1;31m"
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

# Install home-manager if not found
if [[ ! $(which home-manager) ]]; then
    echo hello
fi

pecho "Applying home-manager config"
case "$(uname -s)" in
    Linux) system=personalLinux;;
    Darwin)
        case "$(whoami)" in
            jenterkin) system=personalDarwin;;
            jordanenterkin) system=work;;
            *) system="unknown";;
        esac;;
    *) system="unknown";;
esac

if [[ "${system}" = "unknown" ]]; then
    perror "Unknown system. Verify that your OS and username are correct/supported."
    exit
fi

home-manager switch --flake ~/repos/dot-files/#${system} -v
