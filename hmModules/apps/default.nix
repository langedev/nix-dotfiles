{ lib, ... }: let
  fs = lib.fileset;
  appFilter = {name, ...}: name == "app.nix";
in {
  imports = fs.toList (fs.fileFilter appFilter ./.);
}
