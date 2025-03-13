{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";

    lix-module.url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-2.tar.gz";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland";
    hyprland-contrib.url = "github:hyprwm/contrib";

    sops-nix.url = "github:Mic92/sops-nix";
    ags.url = "github:Aylur/ags";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
  };

  outputs = { self, home-manager, nixpkgs, lix-module, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    fs = pkgs.lib.fileset;
    st = pkgs.lib.strings;
    as = pkgs.lib.attrsets;

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

    userConfig = usernameAtHostname: userpath: home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { 
        inherit inputs; 
        inherit usernameAtHostname;
      };
      modules = [
        ./hmModules
        userpath
      ];
    };

    hostConfig = hostname: hostpath: nixpkgs.lib.nixosSystem {
      specialArgs = let
        hostFilteredUsers = as.filterAttrs (
          name: value: let
            userHostname = builtins.elemAt (st.splitString "@" name) 1;
          in userHostname == hostname
        ) users;

        hostUsers = as.mapAttrsToList (
          name: value: builtins.elemAt (st.splitString "@" name) 0
        ) hostFilteredUsers;
      in {
        inherit inputs;
        inherit hostname;
        "usernameList" = hostUsers;
      };
      modules = [
        ./nixosModules
        hostpath
      ];
    };
  in {
    nixosConfigurations = builtins.mapAttrs (name: path: hostConfig name path) hosts;
    homeConfigurations = builtins.mapAttrs (name: path: userConfig name path) users;
  };
}
