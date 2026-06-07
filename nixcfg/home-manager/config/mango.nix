{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    brightnessctl
    wmenu
    networkmanagerapplet
    grim
    slurp
    wl-clipboard
    mako
    gammastep
  ];
}
