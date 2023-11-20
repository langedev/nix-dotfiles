{
  description = "Home Manager configuration of pan";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:langedev/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:langedev/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { nixpkgs, home-manager, hyprland, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."pan" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          hyprland.homeManagerModules.default
          ./home.nix
        ];
      };
    };
}
