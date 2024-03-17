{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, hyprland, aagl, ... }@inputs:
  {
    nixosConfigurations.onizuka = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        hyprland.nixosModules.default
        { programs.hyprland.enable = true; }
        ./systems/shared
        ./systems/onizuka
      ];
    };

    nixosConfigurations.jibril = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        hyprland.nixosModules.default
        { programs.hyprland.enable = true; }
        ./systems/shared
        ./systems/jibril
      ];
    };
  };
}
