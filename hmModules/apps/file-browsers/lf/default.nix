{ config, pkgs, lib, ... }:

{
  options.lf = {
    enable = lib.mkEnableOption "Enables lf";
    hiddenfiles = lib.mkOption { default = [ ".*" ]; };
    leader = lib.mkOption { default = "<space>"; };
  };

  config = lib.mkIf config.lf.enable {
    xdg.configFile."lf/icons".source = ./icons;



    programs.lf = {
      enable = true;
      settings = {
        # Hide specific files rather than "hidden" files
        hiddenfiles = config.lf.hiddenfiles;
        ratios = [
          2
          3
        ];
        preview = true;
        ignorecase = true;
        icons = true;
        number = true;
        relativenumber = true;
      };
      commands = {
        dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
        trash = lib.mkIf config.trash.enable 
                  ''%${pkgs.trash-cli}/bin/trash "$fx"'';
        mkdir = ''
          ''${{
            printf "Directory Name: "
            read DIR
            mkdir $DIR
          }}
        '';
        mkfile = ''
          ''${{
            printf "File Name: "
            read FILE
            touch $FILE
          }}
        '';
      };
      keybindings = let
        leader = config.lf.leader;
      in {
        "${leader}" = "";
        "v" = ":toggle; down";
        "." = "set hidden!";
        "x" = lib.mkIf config.trash.enable "trash";
        "${leader}d" = "mkdir";
        "${leader}f" = "mkfile";
        "${leader}m" = "dragon-out";
      };
      extraConfig =
      let
        previewer =
          pkgs.writeShellScriptBin "pv.sh" ''
          file=$1
          w=$2
          h=$3
          x=$4
          y=$5

          if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
              ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
              exit 1
          fi

          ${pkgs.pistol}/bin/pistol "$file"
        '';
        cleaner = pkgs.writeShellScriptBin "clean.sh" ''
          ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
        '';
      in
      ''
        set cleaner ${cleaner}/bin/clean.sh
        set previewer ${previewer}/bin/pv.sh
      '';
    };
  };
}
