{ pkgs, ... }:
{
  xdg.configFile."foot/foot.ini".text = ''
    [main]
    font        = Iosevka Nerd Font:size=13
    font-bold   = Iosevka Nerd Font:style=Bold:size=13
    font-italic = Iosevka Nerd Font:style=Italic:size=13
    shell       = /home/ares/.nix-profile/bin/bash
    pad         = 6x6

    [mouse]
    hide-when-typing = yes

    [scrollback]
    lines = 50000

    [tweak]
    grapheme-shaping = no

    [colors-dark]
    background           = 0d0d0d
    foreground           = c0c0c0
    selection-background = 252525
    selection-foreground = c0c0c0

    regular0 = 0d0d0d
    regular1 = 7a3030
    regular2 = 4a6a4a
    regular3 = 686868
    regular4 = 4a6a88
    regular5 = 686868
    regular6 = 4a7a7a
    regular7 = c0c0c0

    bright0  = 2a2a2a
    bright1  = 8a3838
    bright2  = 5a7a5a
    bright3  = 888888
    bright4  = 5a7a98
    bright5  = 888888
    bright6  = 5a8a8a
    bright7  = d8d8d8
  '';

  home.packages = [ pkgs.foot ];
}
