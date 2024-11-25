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
    hosts = let 
      hostFilter = { name, ...}: name == "host.nix";
      hostPaths = fs.toList (fs.fileFilter hostFilter ./hosts);
      # Assumes dir structure is start_of_path/hosts/hostname/host.nix
      extractHostName = path: builtins.unsafeDiscardStringContext (
        st.removeSuffix "/host.nix" (
          builtins.elemAt (st.splitString "/hosts/" path) 1
        )
      );
    in builtins.listToAttrs (map (path: {
      value = path;
      name = extractHostName path;
    }) hostPaths);

    userConfig = extraModules: home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ./hmModules
      ] ++ extraModules;
    };
    users = let
      userFilter = { name, ...}: name == "user.nix";
      userPaths = fs.toList (fs.fileFilter userFilter ./hosts);
    in builtins.listToAttrs (map (path: let
        dirsAndFiles = st.splitString "/" path;
        dAFLength = builtins.length dirsAndFiles;
        # Assumes dir structure is start_of_path/hosts/hostname/users/username/user.nix
        hostname = builtins.unsafeDiscardStringContext (
          builtins.elemAt dirsAndFiles (dAFLength - 4));
        username = builtins.unsafeDiscardStringContext (
          builtins.elemAt dirsAndFiles (dAFLength - 2));
      in {
        name = username + "@" + hostname;
        value = path;
      }
    ) userPaths);
  in {
    nixosConfigurations = builtins.mapAttrs (name: path: hostConfig [ path ]) hosts;
    homeConfigurations = builtins.mapAttrs (name: path: userConfig [ path ]) users;
  };
}
