{ config, pkgs, ... }:

{
  programs.git.enable = true;
  programs.git.userName = "JuliaLange";
  programs.git.userEmail = "git@julialange.com";
  programs.git.extraConfig = {
    safe = {
      directory = "/etc/nixos";
    };
  };
}
