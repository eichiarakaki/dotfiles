{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Communication
    discord

    # Media
    mpv
    imv
    obs-studio

    # Productivity
    drawio
    tradingview

    # Utils
    unzip
    ffmpeg
    htop
    btop
    neofetch
    scrot
    xclip
    pavucontrol
  ];
}
