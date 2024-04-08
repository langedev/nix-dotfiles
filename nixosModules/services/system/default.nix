{ config, pkgs, lib, ... }:

{
  options = {
    user.name = lib.mkOption { default = "pan"; };
    user.timezone = lib.mkOption { default = "America/Los_Angeles"; };
    font.extraFonts = lib.mkOption { default = []; };
  };

  config = {
    # Use the systemd-boot EFI boot loader.
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.loader.systemd-boot.enable = true;
    boot.loader.timeout = 1;
    boot.loader.efi.canTouchEfiVariables = true;

    time.timeZone = config.user.timezone;

    i18n.defaultLocale = "en_US.UTF-8";

    # "Essential" Packages
    environment.systemPackages = with pkgs; [
      git
      neovim
      nnn
      xdg-user-dirs
    ];

    # XDG Compliance
    xdg.portal.config.common.default = "*";
    environment.sessionVariables = rec {
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_CACHE_HOME  = "\${HOME}/.cache";
      XDG_STATE_HOME  = "\${HOME}/.local/state";
      XDG_DATA_HOME   = "\${HOME}/.local/share";
      XDG_BIN_HOME    = "\${HOME}/.local/bin";
      PATH            = [
        "\${HOME}/prog/scripts"
      ];
    };

    users.groups = {
      wheel = { };
      network = { };
    };

    users.users.defaultUser = {
      name = config.user.name;
      isNormalUser = true;
      extraGroups = [ "wheel" "network" ];
    };

    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        cascadia-code
        source-han-sans # Pan-CJK font
      ] ++ config.system.extraFonts;
    };
  };
}