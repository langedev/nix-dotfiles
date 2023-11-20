{ config, pkgs, ... }:

{
  programs.pywal.enable = true;
  home.packages = with pkgs; [
    pywalfox # Update librewolf's colorscheme based on pywal
  ];
}
