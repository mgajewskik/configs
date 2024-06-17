{ config, pkgs, ... }:

# NOTE all the options are in this man file
# man home-configuration.nix

{
  # home.enableNixpkgsReleaseCheck = false;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mgajewskik";
  home.homeDirectory = "/home/mgajewskik";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nixfmt-classic # formatter for nix files used by neovim
    # GUI
    drawio
    vscode
    brave
    firefox
    google-chrome
    cinnamon.nemo-with-extensions
    pavucontrol
    bitwarden-desktop
    obsidian
    ferdium # not sure if needed
    teams-for-linux
    slack
    spotify
    qbittorrent
    flameshot
    evince # GNOME Document Viewer
    postman
    foliate
    libreoffice # was -fresh before
    # gthumb # not working - segfault - 17-06-2024
    # notion-app-enhanced # not working - 16-06-2024
    # beeper # not working - 15-06-2024

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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
    nixpkgs = {
      # doing this way just because Arch needs this file when using standard nix-shell
      # passing this from dotfiles repo might make most sense as I can easily copy it between machines
      recursive = true;
      source = ~/.config/nixpkgs;
      target = "~/.config/nixpkgs";
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mgajewskik/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs = {
    mise = {
      enable = true;
      # not working - zsh needs to be managed by HM probably
      # enableZshIntegration = true;
      settings = {
        experimental = true;
        python_compile = true;
      };
    };

    btop = {
      enable = true;
      settings = { update_ms = 1000; };
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
