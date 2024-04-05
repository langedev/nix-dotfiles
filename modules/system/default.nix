{ config, pkgs, lib, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 1;
  boot.loader.efi.canTouchEfiVariables = true;
  security.polkit.enable = true;

  time.timeZone = "America/Los_Angeles";

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
}
