{ config, pkgs, lib, ... }:

{
  options.colors = {
    enable = lib.mkEnableOption "Enables setting colors using wallust";
  };

  config = lib.mkIf config.colors.enable {
    home.packages = with pkgs; [
      wallust # A better pywal
      pywalfox-native # Update librewolf's colorscheme based on wal
    ];
    xdg.configFile."wallust-config" = {
      target = "wallust/wallust.toml";
      text = ''
        backend = "wal"
        color_space = "lab"
        threshold = 20
        filter = "dark16"

        # [[entry]]
        # # a relative path to a file where wallust.toml is (~/.config/wallust/)
        # template = "dunstrc"
        #
        # # absolute path to the file to write the template (after templating)
        # target = "~/.config/dunst/dunstrc"
      '';
    };
    #xdg.configFile."wallust-templates" = {
    #  source = rootPath + "/templates";
    #  target = "wallust/";
    #};
  };
}
