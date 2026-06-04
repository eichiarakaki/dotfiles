{ pkgs, ... }:

{
  xdg.configFile."ghostty/config".text = ''
    # ------------------------------------------------------------
    # Quant Minimal Ghostty Config
    # ------------------------------------------------------------

    font-family = JetBrains Mono
    font-size = 12
    font-style-bold = JetBrains Mono Bold
    font-style-italic = JetBrains Mono Italic

    window-padding-x = 13
    window-padding-y = 13

    scrollback-limit = 50000

    mouse-hide-while-typing = true

    # Shell
    command = /home/ares/.nix-profile/bin/bash

    # ------------------------------------------------------------
    # Colors (Quant Minimal theme)
    # ------------------------------------------------------------

    background = 252221
    foreground = c8baa4

    selection-background = 3d3837
    selection-foreground = d1c6b4

    palette = 0=#3d3837
    palette = 1=#c65f5f
    palette = 2=#859e82
    palette = 3=#d9b27c
    palette = 4=#829e9b
    palette = 5=#998396
    palette = 6=#ab9382
    palette = 7=#c8baa4

    palette = 8=#413c3a
    palette = 9=#d07a7a
    palette = 10=#9cb598
    palette = 11=#e4c18c
    palette = 12=#96b4b0
    palette = 13=#ad97aa
    palette = 14=#bba595
    palette = 15=#d1c6b4
  '';

  home.packages = with pkgs; [
    ghostty
  ];
}
