{ config, pkgs, lib, ... }:

{
  imports = [
    ./fish
    ./xonsh
    ./zsh
  ];
}