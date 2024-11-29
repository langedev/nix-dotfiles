{ lib, ... }: let
  fs = lib.fileset;
  appFilter = {name, ...}: name == "service.nix";
in {
  imports = fs.toList (fs.fileFilter appFilter ./.);
}
