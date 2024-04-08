{ config, pkgs, lib, ... }:

{
  imports = [
    ./display_manager
    ./nvidia
    ./wayland_compositors
  ];
}
