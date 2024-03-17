{ inputs, pkgs, lib, ... }:

{
  imports =  [ inputs.aagl.nixosModules.default ];
  nix.settings = aagl.nixConfig;

  programs.honkers-railway-launcher.enable = true;
}
