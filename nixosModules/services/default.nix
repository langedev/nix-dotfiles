{ config, pkgs, lib, ... }:

{
  imports = [
    ./graphics
    ./networking
    ./pipewire
    ./polkit
    ./sops-nix
    ./system
  ];
}
