{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    sops-nix.url = "github:Mic92/sops-nix";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
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
