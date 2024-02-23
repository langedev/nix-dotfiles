{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.username = "pan";
  home.homeDirectory = "/home/pan";

  imports = [
    # ./programs/eww
    ./programs/ags
    ./programs/alacritty
    ./programs/discord
    ./programs/dunst
    ./programs/fish
    ./programs/git
    ./programs/hypr
    ./programs/lutris
    ./programs/mpv
    ./programs/nnn
    ./programs/nvim
    ./programs/rofi
    ./programs/spotify
    ./programs/ssh
    ./programs/wal
    ./programs/xdg

    ./services/timers
  ];

  home.packages = with pkgs; [
    # Applications
    beeper # Better Chat App
    gimp # Photo editting
    pamixer # Volume control
    playerctl # Control media
    wget # Download web stuff
    feh # Image viewer
    appimage-run # Lets you run app images
    zathura # PDF viewer
    ani-cli # Easy anime player
    lutgen # LUT generator

    texlive.combined.scheme-full # Latex

    # Development stuff
    nodejs # For compiling JS stuff
    jq # May be critical for scripts?
  ];
  # home.file = {};

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "librewolf";
  };

  home.sessionPath = [
    "$HOME/prog/scripts"
  ];

  # Enable man pages, but ensure ~/.manpage isn't created
  programs.man.enable = true;
  programs.man.generateCaches = false;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "23.05"; # don't change lol, u know why
}
