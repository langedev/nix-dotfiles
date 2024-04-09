{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs-stable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    defaultConfig = extraModules: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./nixosModules
      ] ++ extraModules;
    };
  in
  {
    nixosConfigurations.onizuka = defaultConfig [ ./systems/onizuka ];
    nixosConfigurations.jibril = defaultConfig [ ./systems/jibril ];
  };
}
