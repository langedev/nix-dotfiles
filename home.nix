{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.username = "pan";
  home.homeDirectory = "/home/pan";

  imports = [
    ./programs/xdg
    ./programs/hypr
    ./programs/dunst
    ./programs/git
    ./programs/alacritty
    ./programs/pywal
    ./programs/fish
    ./programs/nnn
    ./programs/rofi
    ./programs/nvim
    ./programs/mpv
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
    # Development stuff, can be removed
    nodejs # For compiling JS stuff
    jq # May be critical for scripts?

    # Check if want settings?
    zathura # PDF viewer

    # Expand into other areas
    sshfs # SSH File system (SSH)
    eww-wayland # eww widgets (EWW)
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
