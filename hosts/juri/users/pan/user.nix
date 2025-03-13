{ config, pkgs, ... }:

{
  fish.enable = true;
  git = {
    enable = true;
    username = "Julia Lange";
    email = "public@julialange.org";
  };
  neovim = {
    enable = true;
    themes.catppuccin.enable = true;
  };
  lf.enable = true;
  zoxide.enable = true;
}
