{ config, pkgs, lib, ... }:

{
  imports = [
    ./bluetooth
    ./wireless
  ];
}
