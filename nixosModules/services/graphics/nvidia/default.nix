{ config, pkgs, lib, ... }:

{
  options = {
    nvidia.enable = lib.mkEnableOption
      "Enables nvidia with proprietary drivers";
  };

  config = lib.mkIf config.nvidia.enable {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
    };

    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    boot.kernelParams = [ "nvidia_drm.fbdev=1" ];

    environment.systemPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };
}
