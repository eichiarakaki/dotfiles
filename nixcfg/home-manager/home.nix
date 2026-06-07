{ config, pkgs, lib, ... }:

{
  imports = [
    ./config/sh.nix
    ./config/fonts.nix
    ./config/core.nix
    ./config/developer.nix
    ./config/env.nix
    ./config/foot.nix
    #./config/helix.nix
    ./config/kakoune.nix

    # ========================
    # DESKTOP ENVIRONMENT
    # ========================
    # Uncomment ONLY ONE of the two lines below:

    #./config/desktop-niri.nix     # ← Niri (Wayland)
    ./config/desktop-i3.nix     # ← i3 (X11)
  ];

  home.username      = "ares";
  home.homeDirectory = "/home/ares";
  home.stateVersion  = "25.05";

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
