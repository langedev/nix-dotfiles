{ config, pkgs, lib, ... }:

{
  import = [
    ./games
    ./input-remapper
    ./librewolf
    ./shells
    ./syncthing
  ];
}
