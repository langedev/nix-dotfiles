{ config, pkgs, lib, ... }:

{
  options.zsh = {
    enable = lib.mkEnableOption "Enable zsh";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      dotDir = ".config/zsh";

      history.save = 10000;
      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";
      initExtra = let
        lf = lib.optionalString config.lf.enable ''
          # Lf changes directory
          lf () {
            cd "$(command ${pkgs.lf}/bin/lf -print-last-dir "$@")"
          }
          bindkey -s '^o' 'lf\n'
        '';

      in lf + ''
        # Nix-shell
        ${pkgs.nix-your-shell}/bin/nix-your-shell zsh | source /dev/stdin

        # Prompt
        autoload -U colors && colors
        autoload -Uz vcs_info
        precmd_vcs_info() { vcs_info }
        precmd_functions+=( precmd_vcs_info )
        setopt prompt_subst
        zstyle ':vcs_info:*' check-for-changes true
        zstyle ':vcs_info:*' unstagedstr '·*'
        zstyle ':vcs_info:*' stagedstr '·+'
        zstyle ':vcs_info:git:*' formats '%b%u%c'
        export PROMPT="%(0?.%F{white}.%? %F{red})τ%f "
        export RPROMPT="%F{yellow}\$vcs_info_msg_0_%f %F{blue}%~%f"
      '';
    };
  };
}
