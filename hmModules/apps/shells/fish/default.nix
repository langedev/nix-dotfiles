{ config, pkgs, lib, ... }:
let
  functionModule = with lib.types; submodule {
    options = {
      body = lib.mkOption { type = lines; };
      wraps = lib.mkOption {
        type = nullOr str;
        default = null;
      };
    };
  };
in {
  options.fish = {
    enable = lib.mkEnableOption "Enables fish";
    extraFunctions = lib.mkOption {
      type = with lib.types; attrsOf (either lines functionModule);
      default = {};
    };
  };

  config = lib.mkIf config.fish.enable {
    programs.fish = {
      enable = true;
      functions = {
        fish_greeting = "";
        fish_prompt = ''
          if test $status -eq 0
              echo -n -s (set_color blue -o) τ " " (set_color normal)
          else
              echo -n -s (set_color red -o) τ " " (set_color normal)
          end
        '';
        fish_right_prompt = ''
          git_prompt
          echo -n -s (set_color blue) (prompt_pwd) " "
          echo -n -s (set_color yellow) $CMD_DURATION ms
          echo -n -s (set_color normal)
        '';
        git_prompt = ''${builtins.readFile ./functions/git_prompt.fish}'';
      } // config.fish.extraFunctions;
    };
  };
}
