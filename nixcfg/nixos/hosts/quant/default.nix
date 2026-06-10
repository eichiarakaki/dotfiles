{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/boot.nix
    ../../modules/networking.nix
    ../../modules/locale.nix
    ../../modules/users.nix
    ../../modules/graphics.nix
    ../../modules/desktop.nix
    ../../modules/audio.nix
    ../../modules/bluetooth.nix
    ../../modules/power.nix
    ../../modules/services.nix
    ../../modules/virtualisation.nix
    ../../modules/packages.nix

    #../../modules/gaming.nix
  ];

  networking.hostName = "quant";

  system.stateVersion = "25.05";
}
