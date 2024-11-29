{ config, pkgs, lib, ... }: let
  fs = lib.fileset;
  shellFilter = {name, ...}: name == "shell.nix";
  shellImports = fs.toList (fs.fileFilter shellFilter ./.);
  shellNames = map (
    path: let
      splitPath = lib.strings.splitString "/" path;
      splitPathLen = builtins.length splitPath;
    in builtins.elemAt splitPath (splitPathLen - 2)
  ) shellImports;
in {
  imports = shellImports;

  options.shell = let 
    shellNameEnum = lib.types.enum shellNames;
  in {
    defaultShell = lib.mkOption {
      type = shellNameEnum;
    };
    enabledShells = lib.mkOption {
      type = lib.types.listOf shellNameEnum;
    };
  };

  config = {
    users.defaultUserShell = pkgs."${config.shell.defaultShell}";
    environment.shells = map (shell: pkgs."${shell}") config.shell.enabledShells;
  };
}
