# Personal Home Configuration

This repo uses [Home Manager](https://github.com/nix-community/home-manager) with a light wrapper around it to automatically install nix and choose the correct configuration based on my system.

## Setup
Just run `./bin/switch` to set up the repo. After it is run you can simply run `switch` to update your home configuration.

## Known Issues
You will have to run `switch` twice to pick up on changes in the file. This is because it is copied over to `~/.bin`, and you need to run `switch` once to update the script, then again for it to run the changes to the script.
