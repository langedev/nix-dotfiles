{ config, pkgs, lib, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "jibril";

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";

  # "Essential" Packages
  environment.systemPackages = with pkgs; [
    git
    neovim
    nnn
    xdg-user-dirs
    blueman
  ];

  # XDG Compliance
  environment.sessionVariables = rec {
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_CACHE_HOME  = "\${HOME}/.cache";
    XDG_STATE_HOME  = "\${HOME}/.local/state";
    XDG_DATA_HOME   = "\${HOME}/.local/share";
    XDG_BIN_HOME    = "\${HOME}/.local/bin";
  };

  users.groups = {
    wheel = { };
    network = { };
  };
}
