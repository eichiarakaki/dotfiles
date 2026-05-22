{ config, pkgs, lib, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        padding = {
          x = 8;
          y = 8;
        };

        opacity = 1.0;
      };

      font = {
        normal = {
          family = "Iosevka Nerd Font";
          style = "Regular";
        };

        bold = {
          family = "Iosevka Nerd Font";
          style = "Bold";
        };

        italic = {
          family = "Iosevka Nerd Font";
          style = "Italic";
        };

        size = 11.0;
      };

      colors = {
        primary = {
          background = "#181818";
          foreground = "#E4E4E4";
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