{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # personalpkgs.url = "github:langedev/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, hyprland, ... }:
  # let
  #   personal-overlay = final: prev: {
  #     personal = personalpkgs.legacyPackages.${prev.system};
  #   };
  # in {
  {
    nixosConfigurations.onizuka = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # ({ config, pkgs, ... }: { nixpkgs.overlays = [ personal-overlay ]; })
        hyprland.nixosModules.default
        { programs.hyprland.enable = true; }
        ./systems/shared
        ./systems/onizuka
      ];
    };

    nixosConfigurations.jibril = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # ({ config, pkgs, ... }: { nixpkgs.overlays = [ personal-overlay ]; })
        hyprland.nixosModules.default
        { programs.hyprland.enable = true; }
        ./systems/shared
        ./systems/jibril
      ];
    };
  };
}
