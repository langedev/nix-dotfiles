{ config, pkgs, ... }:

{
  programs.git.enable = true;
  programs.git.userName = "langedev";
  programs.git.userEmail = "public@daltonlange.com";
  programs.git.extraConfig = {
    safe = {
      directory = "/etc/nixos";
    };
  };
}
