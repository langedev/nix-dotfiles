{
  inputs = {
    nixpkgs.url = "github:langedev/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { nixpkgs, hyprland, ... }: {
    nixosConfigurations.jibril = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
	./configuration.nix 
        hyprland.nixosModules.default
        { programs.hyprland.enable = true; }
      ];
    };
  };
}
