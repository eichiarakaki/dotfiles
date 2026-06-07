{ pkgs, ... }:

{
  programs.kakoune = {
    enable = true;

    config = {
      # Número de líneas relativas
      numberLines = {
        enable = true;
        relative = true;
      };

      # Mostrar matching de paréntesis
      showMatching = true;

      # Scrolloff (espacio alrededor del cursor)
      scrollOff = {
        columns = 5;
        lines = 3;
      };

      # Tabulación
      tabStop = 4;
      indentWidth = 4;

    };

    # ======================== TEMA GRUBER DARKER ========================
    extraConfig = ''
      # Gruber Darker theme for Kakoune
      # Based on the Emacs Gruber Darker theme

      face global Default            rgb:e4e4e4,rgb:181818
      face global PrimarySelection   rgb:181818,rgb:ffdd33
      face global SecondarySelection rgb:181818,rgb:52494e
      face global PrimaryCursor      rgb:181818,rgb:e4e4e4
      face global SecondaryCursor    rgb:181818,rgb:52494e
      face global PrimaryCursorEol   rgb:181818,rgb:e4e4e4
      face global SecondaryCursorEol rgb:181818,rgb:52494e

      face global LineNumbers        rgb:52494e
      face global LineNumberCursor   rgb:e4e4e4
      face global LineNumbersWrapped rgb:52494e

      face global MenuForeground     rgb:e4e4e4,rgb:52494e
      face global MenuBackground     rgb:e4e4e4,rgb:282828
      face global MenuInfo           rgb:ffdd33

      face global Information        rgb:ffdd33
      face global Error              rgb:f43841
      face global StatusLine         rgb:e4e4e4,rgb:282828
      face global StatusLineMode     rgb:ffdd33
      face global StatusLineInfo     rgb:96a6c8
      face global StatusLineValue    rgb:73d936

      face global Prompt             rgb:ffdd33
      face global MatchingChar       rgb:ffdd33,rgb:52494e

      face global BufferPadding      rgb:52494e

      # Sintaxis
      face global keyword            rgb:ffdd33
      face global attribute          rgb:96a6c8
      face global type               rgb:96a6c8
      face global string             rgb:73d936
      face global comment            rgb:52494e
      face global function           rgb:e4e4e4
      face global variable           rgb:e4e4e4
      face global constant           rgb:ffdd33
      face global operator           rgb:e4e4e4
      face global meta               rgb:9e95c7
    '';
  };
}
