{ config, pkgs, lib, ... }:

{
  options = {
    wireless.enable = lib.mkEnableOption "Enables wireless";
  };

  config = lib.mkIf confi.wireless.enable {
    networking.wireless = {
      enable = true;
      userControlled = {
        enable = true;
        group = "network";
      };
      networks = {
        "foofoo2" = {
          pskRaw = "1269f8db0aec9d9c30bff6de9951f0ab2d18d7cea4dacd8bd253ebc237e73e2d";
          priority = 1;
        };
        "OrbiWanKenobe" = {
          pskRaw = "0128447a146d359c1224e558b0f4e3fc0a53b0b4a178334075b50f8d07e179d2";
          priority = 1;
        };
        "Homura" = {
          pskRaw = "dd77456e1df3f2c17bccc917a0e609684fa6d2ccb6a2e0fb122d50d243e0c87e";
          priority = 0;
        };
      };
    };

    networking.enableIPv6 = false;
  };
}
