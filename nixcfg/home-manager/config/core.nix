{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Communication
    vesktop

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
    fastfetch
    btop
    pavucontrol
  ];
}
