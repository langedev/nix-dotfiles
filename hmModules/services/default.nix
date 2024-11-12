{ config, pkgs, ... }:

{
  imports = [
    ./dunst
    ./home
    ./manpages
    ./ssh
    ./timers
    ./trash
    ./wal
    ./widgets
  ];
}
