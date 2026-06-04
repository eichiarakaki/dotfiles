{ pkgs, ... }:

{
  home.packages = with pkgs; [
    helix
    wl-clipboard
  ];

  programs.helix = {
    enable = true;

    settings = {
      theme = "quant";

      editor = {
        line-number = "relative";
        mouse = true;
        cursorline = true;
        color-modes = false;
        scrolloff = 8;
        auto-format = false;
        true-color = true;
        bufferline = "never";
        rulers = [ ];

        soft-wrap = {
          enable = true;
          wrap-indicator = "";
        };

        clipboard-provider = "wayland";
        default-yank-register = "+";

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        statusline = {
          left = [ "file-name" ];
          center = [ ];
          right = [ ];
        };

        lsp = {
          display-messages = true;
        };
      };

      keys.insert = {
        k = {
          j = "normal_mode";
        };
      };
    };

    themes.quant = {
      # ------------------------------------------------------------
      # UI
      # ------------------------------------------------------------

      "ui.background" = {
        bg = "#252221";
      };

      "ui.text" = {
        fg = "#c8baa4";
      };

      "ui.text.focus" = {
        fg = "#d1c6b4";
      };

      "ui.selection" = {
        bg = "#3d3837";
      };

      "ui.cursor" = {
        fg = "#252221";
        bg = "#d9b27c";
      };

      "ui.cursor.match" = {
        fg = "#252221";
        bg = "#998396";
      };

      "ui.cursorline" = {
        bg = "#262322";
      };

      "ui.linenr" = {
        fg = "#3d3837";
      };

      "ui.linenr.selected" = {
        fg = "#beae94";
      };

      "ui.statusline" = {
        fg = "#c8baa4";
        bg = "#302c2b";
      };

      "ui.statusline.inactive" = {
        fg = "#ab9382";
        bg = "#252221";
      };

      "ui.window" = {
        fg = "#3d3837";
      };

      "ui.menu" = {
        fg = "#c8baa4";
        bg = "#302c2b";
      };

      "ui.popup" = {
        fg = "#c8baa4";
        bg = "#302c2b";
      };

      "ui.help" = {
        fg = "#c8baa4";
        bg = "#302c2b";
      };

      "ui.virtual" = {
        fg = "#ab9382";
      };

      # Required by Helix
      "ui.cursor.primary" = {
        fg = "#252221";
        bg = "#d9b27c";
      };

      "ui.selection.primary" = {
        bg = "#3d3837";
      };

      # ------------------------------------------------------------
      # Syntax
      # ------------------------------------------------------------

      "comment" = {
        fg = "#3d3837";
        modifiers = [ "italic" ];
      };

      "keyword" = {
        fg = "#d9b27c";
      };

      "keyword.control" = {
        fg = "#d9b27c";
      };

      "operator" = {
        fg = "#829e9b";
      };

      "namespace" = {
        fg = "#829e9b";
      };

      "type" = {
        fg = "#998396";
      };

      "type.builtin" = {
        fg = "#998396";
      };

      "special" = {
        fg = "#d08b65";
      };

      "string" = {
        fg = "#859e82";
      };

      "constant" = {
        fg = "#ab9382";
      };

      "constant.numeric" = {
        fg = "#ab9382";
      };

      "constant.builtin" = {
        fg = "#ab9382";
      };

      "function" = {
        fg = "#cdc0ad";
      };

      "function.builtin" = {
        fg = "#cdc0ad";
      };

      "variable" = {
        fg = "#c8baa4";
      };

      "variable.parameter" = {
        fg = "#beae94";
      };

      "label" = {
        fg = "#d08b65";
      };

      "attribute" = {
        fg = "#829e9b";
      };

      "tag" = {
        fg = "#998396";
      };

      # ------------------------------------------------------------
      # Diagnostics
      # ------------------------------------------------------------

      "hint" = {
        fg = "#829e9b";
      };

      "info" = {
        fg = "#728797";
      };

      "warning" = {
        fg = "#d08b65";
      };

      "error" = {
        fg = "#c65f5f";
      };
    };
  };
}
