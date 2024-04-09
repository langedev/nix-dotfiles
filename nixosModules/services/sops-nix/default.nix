{ inputs, config, pkgs, lib, ... }:
let rootPath = ./.; in
{
  options = {
    sops-nix.enable = lib.mkEnableOption "Enables nix-sops for secret management";
  };

  imports =  [ inputs.sops-nix.nixosModules.sops ];

  config = lib.mkIf config.sops-nix.enable {

    sops = {
      defaultSopsFile = rootPath + "secrets.yaml";
      defaultSopsFormat = "yaml";
      age.keyFile = "/home/" + config.user.name + ".config/sops/age/keys.txt";
    };
    environment.systemPackages = with pkgs; [
      sops
    ];
  };
}
