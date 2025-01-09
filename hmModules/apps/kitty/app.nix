{ config, lib, ... }:

{
  options.kitty = {
    enable = lib.mkEnableOption "Enables kitty";
    make_default = lib.mkEnableOption "Makes kitty default terminal emulator";
    font = lib.mkOption { default = ""; };
    font_size = lib.mkOption { default = 18; };
    theme = {
      catppuccin.enable = lib.mkEnableOption "Enables catppuccin theme for kitty";
    };
  };

  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      settings = {
        font_family = config.kitty.font;
        font_size = config.kitty.font_size;
        enable_audio_bell = "no";
        confirm_os_window_close = 0;
      };
      themeFile = lib.mkIf config.kitty.theme.catppuccin.enable "Catppuccin-Mocha";
    };
    defaultApps.terminal = lib.mkIf config.kitty.make_default "kitty";
  };
}
