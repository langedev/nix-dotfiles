{ inputs, config, pkgs, lib, ... }:

{
  options.sops-nix = let
    externalPath = lib.mkOptionType {
      name = "externalPath";
      check = x: !lib.path.hasStorePathPrefix (/. + x);
      merge = lib.mergeEqualOption;
    };
  in {
    enable = lib.mkEnableOption "Enables nix-sops for secret management";
    keyFile = lib.mkOption {
      description = "A key file to unlock your secrets file";
      type = lib.types.nullOr externalPath;
    };
    sopsFile = lib.mkOption {
      description = "The path to your secrets file";
      type = lib.types.path;
    };
    secrets = lib.mkOption { default = {}; };
  };

  imports =  [ inputs.sops-nix.nixosModules.sops ];

  config = lib.mkIf config.sops-nix.enable {
    sops = {
      defaultSopsFile = config.sops-nix.sopsFile;
      age.keyFile = config.sops-nix.keyFile;
      secrets = config.sops-nix.secrets;
    };
    environment.systemPackages = with pkgs; [
      sops
    ];
  };
}
