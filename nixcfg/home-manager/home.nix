{ config, pkgs, lib, ... }:

{
  imports = [
    ./config/sh.nix
    ./config/fonts.nix
    ./config/core.nix
    ./config/developer.nix
    ./config/i3.nix
    ./config/alacritty.nix
  ];

  home.username    = "ares";
  home.homeDirectory = "/home/ares";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    EXTERNAL_HDD_UUID  = "d3d59702-c7b0-4654-ba29-256bb69310d6";
    EXTERNAL_HDD_MOUNT = "$HOME/media/external_hdd";
  };

  home.activation.createMediaDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/media/external_hdd"
  '';

  programs.home-manager.enable = true;
}
