{ config, pkgs, lib, ... }:

{
  imports = [
    ./config/sh.nix
    ./config/fonts.nix
    ./config/core.nix
    ./config/developer.nix
    ./config/env.nix
    ./config/wayland.nix
    ./config/river.nix
    ./config/foot.nix
    ./config/vim.nix
    ./config/tofi.nix
    ./config/emacs.nix
  ];

  home.username      = "ares";
  home.homeDirectory = "/home/ares";
  home.stateVersion  = "25.05";

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
}
