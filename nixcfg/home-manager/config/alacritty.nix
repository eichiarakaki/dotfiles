
{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "Iosevka";
          style = "Regular";
        };
        bold = {
          family = "Iosevka";
          style = "Bold";
        };
        italic = {
          family = "Iosevka";
          style = "Italic";
        };
        size = 10.0;
      };

      window = {
        padding = {
          x = 14;
          y = 14;
        };
        decorations = "full";
        opacity = 1.0;
      };

      cursor = {
        style = {
          shape = "Block";
          blinking = "Never";
        };
      };

      colors = {
        primary = {
          background = "#181818";
          foreground = "#E4E4E4";
        };
        cursor = {
          text = "#181818";
          cursor = "#E4E4E4";
        };
        normal = {
          black   = "#181818";
          red     = "#F43841";
          green   = "#73D936";
          yellow  = "#FFDD33";
          blue    = "#96A6C8";
          magenta = "#9E95C7";
          cyan    = "#95A99F";
          white   = "#E4E4E4";
        };
        bright = {
          black   = "#52494E";
          red     = "#FF4F58";
          green   = "#73D936";
          yellow  = "#FFDD33";
          blue    = "#96A6C8";
          magenta = "#AFAFD7";
          cyan    = "#95A99F";
          white   = "#F5F5F5";
        };
      };
    };
  };
}
