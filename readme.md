# Home-manage

location of this repo:
~/.config/home-manager/

installation steps:
https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone

# Commands

- clone this repo
```
git clone git@github.com:BramDeCneudt/home-manager.git ~/.config/home-manager/
```

- list all channels
```
nix-channel --list
```

- update a channel
```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-channel --add https://nixos.org/channels/nixos-23.11 nixpkgs
nix-channel --update
```

- build home-manager
```
home-manager build
```

- build and activate the config
```
home-manager switch
```
# Notes
- have a look how you you can have a nix-env per repo
https://nixos.wiki/wiki/Development_environment_with_nix-shell
