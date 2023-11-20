{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.username = "pan";
  home.homeDirectory = "/home/pan";

  xdg.enable = true;

  imports = [
    ./programs/hypr
    ./programs/dunst
    ./programs/git
    ./programs/alacritty
    ./programs/pywal
    ./programs/fish
    ./programs/nnn
    ./programs/rofi
  ];

  home.packages = with pkgs; [
    eww-wayland # eww widgets
    socat # For hyprland scripts
    swww # Wallpaper engine
    trash-cli # Trash application
    dunst # Notification Manager
    wlr-randr # Xrandr for wayland

    # Applications
    syncthing # For syncing files between computers
    discord # Chat app
    gimp # Photo editting
    mpv # Video player
    pamixer # Volume control
    playerctl # Control media
    wget # Download web stuff
    zathura # PDF viewer
    feh # Image viewer
    sshfs # SSH File system
    appimage-run # Lets you run app images

    # Development stuff, can be removed
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
