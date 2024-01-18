{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bram";
  home.homeDirectory = "/home/bram";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.zellij
    pkgs.zsh
    pkgs.rustc
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/bram/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Package configurations

  programs.wezterm = {
      enable = true;
    };

  ## Zsh
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    shellAliases = {
      hupdate = "home-manager switch";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
   oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "simple";
    };
    initExtra = ''

export FLYCTL_INSTALL="/home/bram/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

if [ -e /home/bram/.nix-profile/etc/profile.d/nix.sh ]; then . /home/bram/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

[ -f "/home/bram/.ghcup/env" ] && source "/home/bram/.ghcup/env" # ghcup-env

alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# pnpm
export PNPM_HOME="/home/bram/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

EDITOR="/usr/bin/nvim"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

#global alias
alias test='echo test'
alias reload='source ~/.bashrc && echo "reloaded bashrc, enjoy!"'
alias back='cd ../'

#git alias
alias gs='git status'
alias gp='git pull'
alias gpp='git pull && git push'

alias gd='git diff'
alias gdh='git diff .'
alias gdc='git diff --cached'

alias gac='git add --all . && git commit'
alias gc='git clone'
alias gl='git log'

alias gm='git checkout master'
alias gcd='git checkout develop'


#setting alias
alias setbashrc='vim ~/.bashrc'
alias setalias='vim ~/.bash_alias'
alias setfunction='vim ~/.bash_function'

alias setgitignore='vim .gitignore'

#project alias
alias base="cd ~/base"
alias staging="cd ~/staging"
alias tasks="vim ~/tasks"

#maven alias
alias mc="mvn clean"
alias mci="mvn clean install"
alias mcist="mvn clean install -DskipTests"
alias mcise="mvn clean install -Denforcer.skip=true"
alias mcistse="mvn clean install -DskipTests -Denforcer.skip=true"

# pnpm end
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


    '';
  };

}
