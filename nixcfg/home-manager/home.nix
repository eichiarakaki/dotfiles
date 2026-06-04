{ config, pkgs, lib, ... }:

{
  imports = [
    ./config/sh.nix
    ./config/fonts.nix
    ./config/core.nix
    ./config/developer.nix
    ./config/env.nix
    ./config/wayland.nix
    ./config/waybar.nix
    ./config/fuzzel.nix
    #./config/river.nix
    #./config/dwl.nix
    #./config/foot.nix
    # ./config/vim.nix
    ./config/helix.nix
    ./config/ghostty.nix
    #./config/tofi.nix
    #./config/emacs.nix
    ./config/niri.nix
  ];

  home.username      = "ares";
  home.homeDirectory = "/home/ares";
  home.stateVersion  = "25.05";

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
}
