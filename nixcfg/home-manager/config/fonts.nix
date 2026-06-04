{ pkgs, lib, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    source-han-sans
    source-han-serif

    jetbrains-mono
    nerd-fonts.jetbrains-mono

    cascadia-code    # Iosevka

    iosevka
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
  ];

  home.activation.fontCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.fontconfig}/bin/fc-cache -fv
  '';
}
