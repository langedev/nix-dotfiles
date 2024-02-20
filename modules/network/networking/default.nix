{ config, pkgs, lib, ... }:

{
  networking.wireless = {
    enable = true;
    userControlled = {
      enable = true;
      group = "network";
    };
    networks = {
      "The Kabal 2.4" = {
        pskRaw = "56302c1b1c7499f4a4f0e01cefe14b4393c5092420ebf71c68336cd084acd357";
        priority = 1;
      };
      "WWUwireless-Secure" = {
        auth = ''
          key_mgmt=WPA-EAP
          eap=PEAP
          identity="langed@wwu.edu"
          password="Slashed-Tidy4-Cubbyhole"
        '';
        priority = 1;
      };
      "Yellowsticky" = {
        pskRaw = "8984d7e1e2f5bd9c3ccf92e429886bc64d40d42d4771ed5946556227afa4abf0";
        priority = 1;
      };
      "Lange" = {
        pskRaw = "bbbbf63e23747bc0ff36aed4c20dcee0221a6ccb2d2db07e4c64058e645e5f1e";
        priority = 1;
      };
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
}
