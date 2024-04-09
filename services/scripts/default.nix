{ config, pkgs, ... }:

let
  select = import ./select.nix { inherit pkgs; };
in
{
  home.packages = [
    select
  ];
}
