{ config, pkgs, ... }:

{
  home.username = "pan";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.05";

  hypr.enable = true;
  hypr.monitor = {
    details = [
      "DP-2,2560x1440@144,0x0,1"
      "DP-1,2560x1440@144,-2560x0,1"
      "HDMI-A-1,disable"
    ];
    primary = "DP-2";
    secondary = "DP-1";
  };
  hypr.workspace = {
    workspaces = {
      "DP-2" = [
        "home"
        "web"
        "med"
        "game"
      ];
      "DP-1" = [
        "chat"
      ];
    };
    scratchpad.enable = true;
    defaults = {
      "name:web" = [ "librewolf" ];
      "name:med" = [ "librewolf,title:Picture-in-Picture" ];
      "name:chat" = [ "Beeper" ];
      "name:game" = [ "lutris" "explorer.exe" ];
    };
  };
  windows.opaque = [
    "initialTitle:^(Discord Popout)$"
    "class:^(firefox)$"
    "class:^(Gimp)$"
    "class:^(feh)$"
    "class:^(mpv)$"
  ];
  hypr.background = {
    enable = true;
    path = "${config.home.homeDirectory}/med/pix/bg.png";
  };
  hypr.cursor = {
    enable = true;
    theme = "miku";
  };
  hypr = {
    screenshot.enable = true;
    mouse.sensitivity = -0.52;
    polkit.enable = true;
    master.mfact = 0.53;
    xwayland.videobridge.enable = true;
  };
  ags.enable = true;
  rofi.enable = true;

  timer.enableHourly = true;
  timer.enableQuarterly = true;
  colors.enable = true;
  manpages.enable = true;
  trash.enable = true;

  fish.enable = true;
  kitty.enable = true;
  kitty.make_default = true;
  kitty.font = "Cascadia Code";
  git.enable = true;
  git.username = "Julia Lange";
  git.email = "public@julialange.org";
  ssh.enable = true;
  librewolf.enable = true;
  librewolf.make_default = true;

  mpv.enable = true;
  zathura.enable = true;
  feh.enable = true;

  neovim.enable = true;
  neovim.languages = {
    c.enable = true;
    nix.enable = true;
    rust.enable = true;
  };
  neovim.plugins = {
    comments.enable = true;
    fugitive.enable = true;
    lualine.enable = true;
    luasnip.enable = true;
    nvimcmp.enable = true;
    telescope = {
      enable = true;
      fzf.enable = true;
    };
    treesitter.enable = true;
    wiki.enable = true;
  };

  lf.enable = true;
  lf.hiddenfiles = [
    "${config.home.homeDirectory}/.librewolf"
    "${config.home.homeDirectory}/.nix-defexpr"
    "${config.home.homeDirectory}/.nix-profile"
    "${config.home.homeDirectory}/.nv"
    "${config.home.homeDirectory}/.pki"
    "${config.home.homeDirectory}/.steam*"
    "${config.home.homeDirectory}/.zshenv"
  ];
  zoxide.enable = true;

  gimp.enable = true;

  beeper.enable = true;
  discord.enable = true;

  lutris.enable = true;

  extraPkgs = with pkgs; [
      # Applications
      ani-cli # Easy anime player
      lutgen # LUT generator
      prismlauncher # Minecraft launcher
      jdk8 # For playing older minecraft
      gnucash # Personal Finance Manager
      zoom-us # Zoom
  ];
}
