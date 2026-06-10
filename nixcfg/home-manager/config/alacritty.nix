{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      general = {
        import = [
          "${./alacritty/themes/gruvbox-dark-hard-contrast.toml}"
        ];

        live_config_reload = true;
      };

      window = {
        padding = {
          x = 14;
          y = 14;
        };

        decorations = "full";
        opacity = 1.0;
      };

      font = {
        size = 11.0;

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

        bold_italic = {
          family = "Iosevka";
          style = "Bold Italic";
        };
      };

      cursor = {
        style = {
          shape = "Block";
          blinking = "Never";
        };
      };

      mouse = {
        hide_when_typing = true;
      };
    };
  };
}
