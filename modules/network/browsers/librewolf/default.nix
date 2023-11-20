{ config, pkgs, lib, ... }:

{
  	environment.variables.WEBBROWSER = "librewolf";
	environment.systemPackages = with pkgs; [ librewolf ];
}
