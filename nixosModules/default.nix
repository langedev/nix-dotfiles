{ config, pkgs, lib, ... }:

{
  imports = [
    ./apps
    ./automatic
    ./services
  ];
}
