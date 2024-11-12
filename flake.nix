{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland";
    hyprland-contrib.url = "github:hyprwm/contrib";

    sops-nix.url = "github:Mic92/sops-nix";
    ags.url = "github:Aylur/ags";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
  };

  outputs = { self, home-manager, nixpkgs, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    hostConfig = extraModules: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = system;
      modules = [
        ./nixosModules
      ] ++ extraModules;
    };

    userConfig = extraModules: home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ./hmModules
      ] ++ extraModules;
    };
  in
  {
    nixosConfigurations.onizuka = hostConfig [ ./hosts/onizuka ];
    homeConfigurations."pan@onizuka" = userConfig [ ./hosts/onizuka/users/pan ];

    nixosConfigurations.jibril = hostConfig [ ./hosts/jibril ];
    homeConfigurations."pan@jibril" = userConfig [ ./hosts/jibril/users/pan ];
  };
}
