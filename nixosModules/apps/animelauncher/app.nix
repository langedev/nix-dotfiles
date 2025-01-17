{ config, inputs, lib, ... }:

{
  options.aagl = {
    enable = lib.mkEnableOption
      "Enables another anime game launcher settings";
    honkai-rail = lib.mkEnableOption
      "Enables honkai star rail";
    genshin = lib.mkEnableOption
      "Enables genshin impact";
    honkai-3rd = lib.mkEnableOption
      "Enables honkai 3rd impact";
  };

  imports =  [ inputs.aagl.nixosModules.default ];

  config = lib.mkIf config.aagl.enable {
    nix.settings = inputs.aagl.nixConfig;

    programs.honkers-railway-launcher.enable =
      lib.mkIf config.aagl.honkai-rail true;
    programs.anime-game-launcher.enable =
      lib.mkIf config.aagl.genshin true;
    programs.honkers-launcher.enable =
      lib.mkIf config.aagl.honkai-3rd true;
  };
}
