{
  description = "Home Manager configuration of pan";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland";
    hyprland-contrib.url = "github:hyprwm/contrib";
    ags.url = "github:Aylur/ags";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    defaultConfig = extraModules: home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ./hmModules
      ] ++ extraModules;
    };
  in {
    homeConfigurations."pan@onizuka" = defaultConfig [ ./systems/onizuka ];
    homeConfigurations."pan@jibril" = defaultConfig [ ./systems/jibril ];
  };
}
