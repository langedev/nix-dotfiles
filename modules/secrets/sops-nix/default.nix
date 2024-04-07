{ inputs, pkgs, lib, ... }:
let rootPath = ./.; in
{
  imports =  [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = rootPath + "secrets.yaml";
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/pan/.config/sops/age/keys.txt";
  };
}
