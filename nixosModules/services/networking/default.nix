{ config, pkgs, lib, ... }:

{
  import = [
    ./bluetooth
    ./wireless
  ];
}
