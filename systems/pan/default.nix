{ config, pkgs, ... }:

{
  home.username = "pan";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.05";

  hypr.enable = true;
  ags.enable = true;
  rofi.enable = true;

  timer.enableHourly = true;
  timer.enableQuarterly = true;
  colors.enable = true;
  manpages.enable = true;
  trash.enable = true;

  fish.enable = true;
  kitty.enable = true;
  kitty.font = "Cascadia Code";
  git.enable = true;
  git.username = "Julia Lange";
  git.email = "public@julialange.org";
  ssh.enable = true;

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
  ];
}
