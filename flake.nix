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
    fs = pkgs.lib.fileset;
    st = pkgs.lib.strings;

    hostConfig = extraModules: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = system;
      modules = [
        ./nixosModules
      ] ++ extraModules;
    };
    hostFilter = { name, ...}: name == "host.nix";
    hostPaths = fs.toList (fs.fileFilter hostFilter ./hosts);

    hosts = builtins.listToAttrs (map (path: {
      value = hostConfig [ path ];
      name = builtins.unsafeDiscardStringContext (st.removeSuffix "/host.nix" (
        builtins.elemAt (st.splitString "/hosts/" path) 1
      ));
    }) hostPaths);

    userConfig = extraModules: home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ./hmModules
      ] ++ extraModules;
    };

  in {
    nixosConfigurations = hosts;

    homeConfigurations."pan@onizuka" = userConfig [ ./hosts/onizuka/users/pan ];
    homeConfigurations."pan@jibril" = userConfig [ ./hosts/jibril/users/pan ];
  };
}
