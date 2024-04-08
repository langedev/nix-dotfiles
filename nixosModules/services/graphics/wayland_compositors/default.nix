{ inputs, config, pkgs, lib, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "Enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    imports =  [ inputs.hyprland.nixosModules.default ];
    programs.hyprland.enable = true;
    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
}
