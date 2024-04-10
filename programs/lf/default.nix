{ config, pkgs, ... }:

{
  xdg.configFile."lf/icons".source = ./icons;

  home.packages = with pkgs; [
    trash-cli # Trash program for lf
  ];

  programs.lf = {
    enable = true;
    settings = {
      # Hide specific files rather than "hidden" files
      hiddenfiles = [
        "${config.home.homeDirectory}/.librewolf"
        "${config.home.homeDirectory}/.nix-defexpr"
        "${config.home.homeDirectory}/.nix-profile"
        "${config.home.homeDirectory}/.nv"
        "${config.home.homeDirectory}/.pki"
        "${config.home.homeDirectory}/.steam*"
        "${config.home.homeDirectory}/.zshenv"
      ];
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
          mkdir $FILE
        }}
      '';
      trash = ''trash "$fx"'';
    };
    keybindings = {
      ";" = "";
      x = "trash";
      "." = "set hidden!";
      ";d" = "mkdir";
      ";f" = "mkfile";
      ";m" = "dragon-out";
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
}
