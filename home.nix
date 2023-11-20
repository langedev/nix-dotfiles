{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.username = "pan";
  home.homeDirectory = "/home/pan";

  imports = [
    ./programs/alacritty
    ./programs/dunst
    ./programs/eww
    ./programs/fish
    ./programs/git
    ./programs/hypr
    ./programs/mpv
    ./programs/nnn
    ./programs/nvim
    ./programs/pywal
    ./programs/rofi
    ./programs/ssh
    ./programs/xdg
  ];

  home.packages = with pkgs; [
    # Applications
    discord # Chat app
    gimp # Photo editting
    pamixer # Volume control
    playerctl # Control media
    wget # Download web stuff
    feh # Image viewer
    appimage-run # Lets you run app images
    zathura # PDF viewer
    ani-cli # Easy anime player

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

  # Enable man pages, but ensure ~/.manpage isn't created
  programs.man.enable = true;
  programs.man.generateCaches = false;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "23.05"; # don't change lol, u know why
}
