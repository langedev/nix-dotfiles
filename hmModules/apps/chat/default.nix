{ config, pkgs, ... }:

{
  imports = [
    ./discord
    ./beeper
  ];
}
