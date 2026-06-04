{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = [{
      layer = "top";
      position = "top";

      height = 28;

      modules-left = [
        "niri/workspaces"
      ];

      modules-center = [
        "clock"
      ];

      modules-right = [
        "cpu"
        "memory"
        "network"
        "battery"
      ];
    }];

    style = ''
      /* ------------------------------------------------------------
         Quant Minimal Waybar Theme
      ------------------------------------------------------------ */

      * {
        font-family: "JetBrains Mono";
        font-size: 12px;
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      window#waybar {
        background: #252221;
        color: #c8baa4;
      }

      /* ------------------------------------------------------------
         Workspaces (Niri / i3 style mental model)
      ------------------------------------------------------------ */

      #workspaces button {
        padding: 0 8px;
        color: #c8baa4;
        background: transparent;
      }

      #workspaces button.active {
        background: #3d3837;
        color: #d1c6b4;
      }

      #workspaces button.urgent {
        background: #c65f5f;
        color: #252221;
      }

      /* ------------------------------------------------------------
         Modules (CPU / RAM / NET / BATTERY)
      ------------------------------------------------------------ */

      #cpu,
      #memory,
      #network,
      #battery,
      #clock {
        padding: 0 10px;
        color: #c8baa4;
        background: transparent;
      }

      /* subtle emphasis for critical state */
      #battery.critical {
        background: #c65f5f;
        color: #252221;
      }

      #network.disconnected {
        color: #d07a7a;
      }

      /* ------------------------------------------------------------
         Hover (keep minimal, no animations)
      ------------------------------------------------------------ */

      #workspaces button:hover {
        background: #413c3a;
      }
    '';
  };
}
