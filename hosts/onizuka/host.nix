{ ... }:

{
  imports = [
    ./hardware.nix
  ];
  nvidia.enable = true;
  pipewire.enable = true;
  polkit.enable = true;
  tablet.enable = true;

  system.timezone = "America/Los_Angeles";
  system.users.bigWheels = [ "pan" ];

  tuigreet.enable = true;
  hyprland.enable = true;

  steam.enable = true;
  steam.gamemode = true;
  aagl.enable = true;
  aagl.honkai-rail = true;
  input-remapper.enable = true;

  shell.enabledShells = [ "fish" ];
  shell.defaultShell = "fish";
}
