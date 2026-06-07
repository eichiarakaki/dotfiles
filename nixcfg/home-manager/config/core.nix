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

    zoxide
    eza
    bat
  ];

  # ----------------------------
  # CLI tooling
  # ----------------------------
  programs.zoxide.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;

  home.pointerCursor = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables = {
    XCURSOR_SIZE = "24";
  };

}
