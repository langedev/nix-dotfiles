{ config, pkgs, lib, ... }:

{
  imports = [
    ./apps
    ./services
  ];
}
