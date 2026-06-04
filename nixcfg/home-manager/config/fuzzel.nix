{ pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = "JetBrains Mono:size=10";
        terminal = "ghostty";

        #prompt = "› ";
        #placeholder = "search…";

        width = 35;
        horizontal-pad = 20;
        vertical-pad = 14;

        inner-pad = 12;
      };

      colors = {
        background = "252221ff";
        text = "c8baa4ff";

        match = "d9b27cff";
        selection = "3d3837ff";
        selection-text = "d1c6b4ff";

        border = "3d3837ff";
      };

      border = {
        width = 2;
        radius = 2;
      };

      dmenu = {
        exit-immediately-if-empty = true;
      };
    };
  };
}
