{ config, pkgs, ... }:

{
  hypr.enable = true;
  hypr.monitor = {
    details = [
      "eDP-2,2256x1504@60,0x0,1"
    ];
  };
  hypr.workspace = {
    workspaces = {
      "eDP-1" = [
        "home"
        "web"
        "chat"
        "med"
      ];
    };
    scratchpad.enable = true;
    defaults = {
      "name:web" = [ "class:(librewolf)" ];
      "name:med" = [ "class:(librewolf),title:Picture-in-Picture" ];
      "name:chat" = [ "class:(Beeper)" ];
    };
  };
  hypr.windows.opaque = [
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
  # ags.enable = true;
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
  kitty.theme.catppuccin.enable = true;
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
    go.enable = true;
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
  neovim.themes.catppuccin.enable = true;

  lf.enable = true;
  lf.hiddenfiles = [
    "${config.home.homeDirectory}/.librewolf"
    "${config.home.homeDirectory}/.nix-defexpr"
    "${config.home.homeDirectory}/.nix-profile"
    "${config.home.homeDirectory}/.nv"
    "${config.home.homeDirectory}/.pki"
  ];
  zoxide.enable = true;

  beeper.enable = true;
  discord.enable = true;
  extraPkgs = with pkgs; [
    # Applications
    musescore
  ];
}
