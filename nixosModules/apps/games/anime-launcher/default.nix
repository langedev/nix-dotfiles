{ config, inputs, pkgs, lib, ... }:

{
  options = {
    aagl.enable = lib.mkEnableOption
      "Enables another anime game launcher settings";
    aagl.honkai-rail = lib.mkEnableOption
      "Enables honkai star rail";
    aagl.genshin = lib.mkEnableOption
      "Enables genshin impact";
    aagl.honkai-3rd = lib.mkEnableOption
      "Enables honkai 3rd impact";
  };

  config = lib.mkIf config.aagl.enable {
    imports =  [ inputs.aagl.nixosModules.default ];
    nix.settings = inputs.aagl.nixConfig;

    programs.honkers-railway-launcher.enable =
      lib.mkIf config.aagl.honkai-rail true;
    programs.anime-game-launcher.enable =
      lib.mkIf config.aagl.genshin true;
    programs.honkers-launcher.enable =
      lib.mkIf config.aagl.honkai-3rd true;
  };
}
