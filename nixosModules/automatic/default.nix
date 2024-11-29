{ config, inputs, pkgs, lib, hostname, usernameList, ... }:

{
  options = {
    system.timezone = lib.mkOption { default = "America/Los_Angeles"; };
    system.extraFonts = lib.mkOption { default = []; };
    system.doAutoUpgrade = lib.mkEnableOption "Enable auto upgrading system";
    system.users.bigWheels = lib.mkOption { default = []; };
  };

  config = {
    # Use the systemd-boot EFI boot loader.
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.loader.systemd-boot.enable = true;
    boot.loader.timeout = 1;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = hostname;
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "23.05";

    time.timeZone = config.system.timezone;

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
    environment.sessionVariables = {
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_CACHE_HOME  = "\${HOME}/.cache";
      XDG_STATE_HOME  = "\${HOME}/.local/state";
      XDG_DATA_HOME   = "\${HOME}/.local/share";
      XDG_BIN_HOME    = "\${HOME}/.local/bin";
      PATH            = [
        "\${HOME}/prog/scripts"
      ];
    };
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

    system.autoUpgrade = lib.mkIf config.system.doAutoUpgrade {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "--commit-lock-file"
        "-L"
      ];
      operation = "boot";
      dates = "22:30";
      randomizedDelaySec = "30min";
    };

  };
}
