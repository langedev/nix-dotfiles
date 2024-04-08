{ config, pkgs, lib, ... }:

{
  imports = [
    ./games
    ./input-remapper
    ./librewolf
    ./shells
    ./syncthing
  ];
}
