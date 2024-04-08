{ config, pkgs, lib, ... }:

{
  import = [
    ./apps
    ./services
  ];
}
