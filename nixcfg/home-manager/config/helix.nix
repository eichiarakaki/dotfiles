{ pkgs, ... }:

{
  home.packages = with pkgs; [
    helix
    # wl-clipboard
  ];

  programs.helix = {
    enable = true;

    settings = {
      theme = "quant-minimal";

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

        clipboard-provider = "wayland";

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        statusline = {
          left = [ "mode" "file-name" ];
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

    themes = {
      quant-minimal = {
        "ui.background" = {
          bg = "black";
        };

        "ui.text" = {
          fg = "#d8d8d8";
        };

        "ui.cursor" = {
          fg = "black";
          bg = "#d8d8d8";
        };

        "ui.cursorline" = {
          bg = "#0a0a0a";
        };

        "ui.linenr" = {
          fg = "#444444";
        };

        "ui.linenr.selected" = {
          fg = "#888888";
        };

        "ui.statusline" = {
          fg = "#404040";
          bg = "black";
        };

        "ui.statusline.inactive" = {
          fg = "#303030";
          bg = "black";
        };

        "comment" = {
          fg = "#555555";
          modifiers = [ "italic" ];
        };

        "keyword" = {
          fg = "#6f86a8";
        };

        "type" = {
          fg = "#8d739c";
        };

        "string" = {
          fg = "#7a8f6b";
        };

        "constant.numeric" = {
          fg = "#b59a5c";
        };

        "warning" = {
          fg = "#b59a5c";
        };

        "error" = {
          fg = "#b04a4a";
        };

        "function" = {
          fg = "#d8d8d8";
        };

        "variable" = {
          fg = "#d8d8d8";
        };
      };
    };
  };
}
