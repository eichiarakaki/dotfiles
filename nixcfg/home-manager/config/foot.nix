{ pkgs, ... }:

{
  xdg.configFile."foot/foot.ini".text = ''
    [main]
    font        = Jetbrains Mono:size=12
    font-bold   = Jetbrains Mono:style=Bold:size=12
    font-italic = Jetbrains Mono:style=Italic:size=12
    shell       = /home/ares/.nix-profile/bin/bash
    pad         = 13x13

    [mouse]
    hide-when-typing = yes

    [scrollback]
    lines = 50000

    [tweak]
    grapheme-shaping = no

    # ------------------------------------------------------------
    # Quant Minimal
    # ------------------------------------------------------------

    [colors-dark]

    # Base
    background = 252221
    foreground = c8baa4

    # Selection
    selection-background = 3d3837
    selection-foreground = d1c6b4

    # ANSI normal colors
    regular0 = 3d3837
    regular1 = c65f5f
    regular2 = 859e82
    regular3 = d9b27c
    regular4 = 829e9b
    regular5 = 998396
    regular6 = ab9382
    regular7 = c8baa4

    # ANSI bright colors
    bright0 = 413c3a
    bright1 = d07a7a
    bright2 = 9cb598
    bright3 = e4c18c
    bright4 = 96b4b0
    bright5 = ad97aa
    bright6 = bba595
    bright7 = d1c6b4
  '';

  home.packages = [ pkgs.foot ];
}
