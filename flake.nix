{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";
    hyprland.url = "github:hyprwm/Hyprland";
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, hyprland, aagl, sops-nix, ... }@inputs:
  let
    defaultConfig = extraModules: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./systems/shared
      ] ++ extraModules;
    };
  in
  {
    nixosConfigurations.onizuka = defaultConfig [ ./systems/onizuka ];
    nixosConfigurations.jibril = defaultConfig [ ./systems/jibril ];
  };
}
