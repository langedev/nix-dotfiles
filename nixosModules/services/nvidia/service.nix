{ config, pkgs, lib, ... }:

{
  options.nvidia = {
    enable = lib.mkEnableOption
      "Enables nvidia with proprietary drivers";
    open = lib.mkEnableOption "Use open nvidia option for newer cards";
  };

  config = lib.mkIf config.nvidia.enable {
    hardware.graphics = {
      enable = true;
    };

    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      open = if config.nvidia.open then true else false;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    boot.kernelParams = [ "nvidia_drm.fbdev=1" ];

    environment.systemPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };
}
