{ config, pkgs, lib, hostname, usernameList, ... }:

{
  options = {
    system.timezone = lib.mkOption { default = "America/Los_Angeles"; };
    system.extraFonts = lib.mkOption { default = []; };
    system.users.bigWheels = lib.mkOption { default = []; };
  };

  config = {
    # Use the systemd-boot EFI boot loader.
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.loader.systemd-boot.enable = true;
    boot.loader.timeout = 1;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = hostname;
    system.stateVersion = "23.05";

    time.timeZone = config.system.timezone;
    i18n.defaultLocale = "en_US.UTF-8";

    # Packages & Default Packages
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      git
      neovim
      nnn
      xdg-user-dirs
    ];

    # XDG Compliance
    nix.settings.use-xdg-base-directories = true;

    users = {
      users = builtins.listToAttrs (map (
        user: {
          name = user;
          value = {
            name = user;
            isNormalUser = true;
            extraGroups = [ "network" ];
          };
        }
      ) usernameList);
      groups = {
        wheel = {
          members = config.system.users.bigWheels;
        };
        network = { };
      };
    };

    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        cascadia-code
        (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
        source-han-sans # Pan-CJK font
      ] ++ config.system.extraFonts;
    };
  };
}
