{ pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = "JetBrains Mono:size=10";
        terminal = "ghostty";

        prompt = "› ";
        placeholder = "search…";

        width = 35;
        horizontal-pad = 20;
        vertical-pad = 14;
        inner-pad = 12;
      };

      colors = {
        background = "000000ee";
        text = "eaeaeaff";

        match = "7aa6daff";

        selection = "424242ff";
        selection-text = "eaeaeaff";

        border = "666666ff";
      };

      border = {
        width = 1;
        radius = 8;
      };

      dmenu = {
        exit-immediately-if-empty = true;
      };
    };
  };
}
