{ config, pkgs, ... }:

# NOTE all the options are in this man file
# man home-configuration.nix
# https://home-manager-options.extranix.com/

{
  # home.enableNixpkgsReleaseCheck = false;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mgajewskik";
  home.homeDirectory = "/home/mgajewskik";
  # home.pointerCursor = {
  #   name = "phinger-cursors-light";
  #   package = pkgs.phinger-cursors;
  #   size = 21;
  #   gtk = { enable = true; };
  #   x11 = { enable = true; };
  # };
  #
  # fonts.fontconfig.enable = true;
  #
  # xsession = {
  #   enable = true;
  #   windowManager.command = "${pkgs.i3-gaps}/bin/i3";
  #   profileExtra = ''
  #     setxkbmap -layout pl -option "ctrl:nocaps"
  #     xset r rate 200 100
  #     xinput set-prop "TPPS/2 Elan TrackPoint" "libinput Natural Scrolling Enabled" 1
  #     xinput set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Speed" 0.6
  #     xinput set-prop 'TPPS/2 Elan TrackPoint' "libinput Scrolling Pixel Distance" 10
  #
  #     xinput set-prop "ELAN0678:00 04F3:3195 Touchpad" "libinput Accel Speed" 1
  #     xinput set-prop "ELAN0678:00 04F3:3195 Touchpad" "libinput Natural Scrolling Enabled" 1
  #     xinput set-prop "ELAN0678:00 04F3:3195 Touchpad" "libinput Tapping Enabled" 1
  #     xinput set-prop "ELAN0678:00 04F3:3195 Touchpad" "libinput Scrolling Pixel Distance" 10
  #   '';
  # };
  #
  # xresources.properties = {
  #   # NOTE: eDP = 162 DPI, Dell = 110 DPI
  #   # https://winaero.com/find-change-screen-dpi-linux/
  #   "Xft.dpi" = 96;
  #   "Xft.antialias" = 1;
  #   "Xft.autohint" = 0;
  #   "Xft.hinting" = 1;
  #   "Xft.hintstyle" = "hintfull";
  #   "Xft.lcdfilter" = "lcddefault";
  # };
  #
  # gtk = {
  #   enable = true;
  #   theme = {
  #     package = pkgs.arc-theme;
  #     name = "Arc-Dark";
  #   };
  #   iconTheme = {
  #     package = pkgs.papirus-icon-theme;
  #     name = "Papirus-Dark";
  #   };
  #   font = {
  #     name = "JetBrainsMono";
  #     size = 10;
  #   };
  # };
  #
  # qt = {
  #   enable = false;
  #   platformTheme = "gtk";
  # };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  # home.packages = with pkgs; [
  #   # i3-gaps
  #   # i3status
  #   # i3blocks-gaps # not working, unknown key separator
  #   # i3blocks
  #   # i3lock # does not recognize password
  #   # fusuma
  #   # fzf
  #   # zsh-fzf-tab
  #   # ripgrep
  #   # fd
  #   # bat # TODO add bat-extras along with the aliases
  #   # eza
  #   # lf # TODO add lfrc config as a file
  #   # hcloud
  #   # blugon # TODO need to create a service because it does not start automatically
  #   # autorandr
  #   # enhancd # not in nixpkgs
  #   # Coding tools
  #   nixfmt-classic # formatter for nix files used by neovim
  #   bats # bash testing framework
  #   # hostname # suddenly gone from archlinux
  #   # GUI
  #   # drawio
  #   # vscode
  #   # brave # NOTE does not support hardware acceleration and therefore google meet blur
  #   # firefox
  #   # google-chrome
  #   # cinnamon.nemo-with-extensions
  #   pavucontrol
  #   bitwarden-desktop
  #   obsidian
  #   ferdium # not sure if needed
  #   teams-for-linux
  #   slack
  #   spotify
  #   qbittorrent
  #   evince # GNOME Document Viewer
  #   postman
  #   foliate
  #   libreoffice # was -fresh before
  #   discord
  #   haruna
  #   flameshot
  #   gedit
  #   vlc
  #   vokoscreen
  #   zotero
  #   tor-browser
  #   # insync # does not start
  #   # zoom-us # not working
  #   # alacritty # not working
  #   # gthumb # not working - segfault - 17-06-2024
  #   # notion-app-enhanced # not working - 16-06-2024
  #   # beeper # not working - 15-06-2024
  #
  #   (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" "JetBrainsMono" ]; })
  #
  #   # # You can also create simple shell scripts directly inside your
  #   # # configuration. For example, this adds a command 'my-hello' to your
  #   # # environment:
  #   # (pkgs.writeShellScriptBin "my-hello" ''
  #   #   echo "Hello, ${config.home.username}!"
  #   # '')
  # ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file = {
  #   # # Building this configuration will create a copy of 'dotfiles/screenrc' in
  #   # # the Nix store. Activating the configuration will then make '~/.screenrc' a
  #   # # symlink to the Nix store copy.
  #   # ".screenrc".source = dotfiles/screenrc;
  #
  #   # # You can also set the file content immediately.
  #   # ".gradle/gradle.properties".text = ''
  #   #   org.gradle.console=verbose
  #   #   org.gradle.daemon.idletimeout=3600000
  #   # '';
  #   # i3 = {
  #   #   source = ~/configs/.config/i3/config;
  #   #   target = "~/.config/i3/config";
  #   # };
  #
  #   nixpkgs = {
  #     # doing this way just because Arch needs this file when using standard nix-shell
  #     # passing this from dotfiles repo might make most sense as I can easily copy it between machines
  #     recursive = true;
  #     source = ~/.config/nixpkgs;
  #     target = "~/.config/nixpkgs";
  #   };
  # };

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
  # home.sessionVariables = {
  #   EDITOR = "nvim";
  #   VISUAL = "nvim";
  #   ENHANCD_FILTER = "fzf:fzy:peco";
  #   BAT_THEME = "gruvbox-dark";
  # };

  # programs = {
  #   # TODO add zsh config here
  #   # TODO setup git here
  #   # setup dunst
  #   # rofi = {
  #   #   enable = true;
  #   #   theme = "Arc-Dark";
  #   #   font = "JetBrainsMono 12";
  #   #   extraConfig = {
  #   #     show-icons = true;
  #   #     modi = "run,drun";
  #   #     combi-modi = "window,drun,run";
  #   #     run-shell-command = "alacritty --hold -e zsh -ic {cmd} && read";
  #   #     kb-remove-to-eol = "";
  #   #     kb-row-up = "Up,Control+p,Control+k";
  #   #     kb-row-down = "Down,Control+n,Control+j";
  #   #     kb-accept-entry = "Control+m,Return,KP_Enter";
  #   #   };
  #   # };
  #
  #   # starship = {
  #   #   enable = true;
  #   #   enableZshIntegration = true;
  #   #   settings = {
  #   #     add_newline = false;
  #   #     character = {
  #   #       success_symbol = "[➜ ](bold #92E920)";
  #   #       error_symbol = "[✗ ](bold red) ";
  #   #     };
  #   #     directory = {
  #   #       truncate_to_repo = true;
  #   #       style = "bold #89CFF0";
  #   #       substitutions = { "~/semantive" = "~/sem"; };
  #   #     };
  #   #     username = { show_always = false; };
  #   #     hostname = { ssh_only = true; };
  #   #     cmd_duration = {
  #   #       min_time = 1000;
  #   #       format = "󰔛 [$duration]($style) ";
  #   #       style = "bold italic #87A752";
  #   #     };
  #   #     git_branch = {
  #   #       format = " [$symbol$branch]($style) ";
  #   #       symbol = " ";
  #   #       # style = "bold yellow";
  #   #     };
  #   #     git_commit = {
  #   #       commit_hash_length = 8;
  #   #       style = "bold white";
  #   #     };
  #   #     python = {
  #   #       symbol = " ";
  #   #       format =
  #   #         "[$symbol$pyenv_prefix($version )(\\($virtualenv\\))]($style) ";
  #   #     };
  #   #     golang = {
  #   #       symbol = " ";
  #   #       format = "[$symbol$version]($style) ";
  #   #     };
  #   #     terraform = { format = "[󱁢 $version$workspace]($style) "; };
  #   #     line_break = { disabled = true; };
  #   #     status = { disabled = true; };
  #   #     package = { disabled = true; };
  #   #     ruby = { disabled = true; };
  #   #     nodejs = { disabled = true; };
  #   #     aws = { disabled = true; };
  #   #     gcloud = { disabled = true; };
  #   #   };
  #   # };
  #
  #   # TODO add this config
  #   # autorandr = { enable = true; };
  #
  #   # lf = { enable = true; };
  #
  #   # mise = {
  #   #   enable = true;
  #   #   # not working - zsh needs to be managed by HM probably
  #   #   enableZshIntegration = true;
  #   #   settings = {
  #   #     experimental = true;
  #   #     python_compile = true;
  #   #   };
  #   # };
  #
  #   # vim = {
  #   #   enable = true;
  #   #   settings = {
  #   #     background = "dark";
  #   #     expandtab = true;
  #   #     ignorecase = true;
  #   #     relativenumber = true;
  #   #     shiftwidth = 4;
  #   #     tabstop = 4;
  #   #     smartcase = true;
  #   #     undofile = true;
  #   #   };
  #   #   extraConfig = ''
  #   #     syntax on
  #   #     syntax enable
  #   #     filetype plugin indent on
  #   #     set autoindent
  #   #     set smartindent
  #   #     set hlsearch
  #   #   '';
  #   # };
  #
  #   # btop = {
  #   #   enable = true;
  #   #   settings = { update_ms = 1000; };
  #   # };
  #   #
  #   # htop = { enable = true; };
  # };

  # NOTE: needed if X11 session is not managed by Home Manager
  # https://github.com/nix-community/home-manager/issues/2064
  # needed for udiskie
  # systemd.user.targets.tray = {
  #   Unit = {
  #     Description = "Home Manager System Tray";
  #     Requires = [ "graphical-session-pre.target" ];
  #   };
  # };

  # TODO create a new service for blugon
  # services = {
  #   # dunst = {
  #   #   enable = true;
  #   #   settings = {
  #   #     global = {
  #   #       monitor = 0;
  #   #       follow = "mouse";
  #   #       # TODO finish setting this up
  #   #     };
  #   #   };
  #   # };
  #
  #   # udiskie = { enable = true; };
  #   # autorandr = { enable = true; };
  # };

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
