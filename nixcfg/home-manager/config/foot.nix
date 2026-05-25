{ pkgs, ... }:

{
  # Use xdg.configFile directly — the HM foot module has type-checking quirks
  # that reject valid foot.ini values like pad = "8x8"
  xdg.configFile."foot/foot.ini".text = ''
    [main]
    font        = Iosevka Nerd Font:size=13
    font-bold   = Iosevka Nerd Font:style=Bold:size=13
    font-italic = Iosevka Nerd Font:style=Italic:size=13
    shell       = /home/ares/.nix-profile/bin/bash 
    pad         = 8x8

    [mouse]
    hide-when-typing = yes

    [scrollback]
    lines = 10000

    [tweak]
    grapheme-shaping = no

    [colors-dark]
    background = 181818
    foreground = e4e4e4

    # Normal colors
    regular0 = 181818
    regular1 = f43841
    regular2 = 73d936
    regular3 = ffdd33
    regular4 = 96a6c8
    regular5 = 9e95c7
    regular6 = 95a99f
    regular7 = e4e4e4

    # Bright colors
    bright0 = 52494e
    bright1 = ff4f58
    bright2 = 73d936
    bright3 = ffdd33
    bright4 = 96a6c8
    bright5 = afafd7
    bright6 = 95a99f
    bright7 = f5f5f5
  '';

  home.packages = [ pkgs.foot ];
}
