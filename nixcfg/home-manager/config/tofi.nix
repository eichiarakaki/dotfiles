{ ... }:
{
  xdg.configFile."tofi/config" = {
    force = true;
    text = ''
      anchor = top
      width = 100%
      height = 25
      horizontal = true

      font = Iosevka NF
      font-size = 13

      outline-width = 0
      border-width = 0
      corner-radius = 0

      padding-top = 0
      padding-bottom = 0
      padding-left = 4
      padding-right = 4

      background-color = #0d0d0d
      text-color = #c0c0c0
      prompt-color = #606060
      selection-color = #0d0d0d
      selection-background = #4d657a

      min-input-width = 120
      result-spacing = 15
      hide-cursor = true
    '';
  };
}
