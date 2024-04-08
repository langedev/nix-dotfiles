{ config, pkgs, lib, ... }:

{
  import = [
    ./graphics
    ./networking
    ./pipewire
    ./polkit
    ./sops-nix
    ./system
  ];
}
