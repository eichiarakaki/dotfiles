{ ... }:

{
  xdg.configFile."tofi/config" = {
    force = true;
    text = ''
      # Position — top bar like dmenu
      anchor = top
      width = 100%
      height = 25
      horizontal = true

      # Font
      font = Iosevka NF
      font-size = 13

      # No borders, no outlines
      outline-width = 0
      border-width = 0
      corner-radius = 0

      # No padding
      padding-top = 0
      padding-bottom = 0
      padding-left = 4
      padding-right = 4

      # Colors — same palette as foot/alacritty
      background-color = #181818
      text-color = #e4e4e4
      selection-color = #e4e4e4
      selection-background = #002b36
      prompt-color = #95a99f

      # Prompt
      #prompt-text = run: 

      # Behaviour
      min-input-width = 120
      result-spacing = 15
      hide-cursor = true
    '';
  };
}
