{ config, pkgs, lib, ... }:

{
  programs.fish.enable = true;

  users.defaultUserShell = pkgs.fish;

  environment.shells = with pkgs; [ fish ];

  # environment.variables.NIX_BUILD_SHELL = "fish";
}
