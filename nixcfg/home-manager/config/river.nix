{ config, pkgs, lib, ... }:

let
  mod = "Super";

  # Audio
  volUp   = "spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+'";
  volDown = "spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'";
  volMute = "spawn 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'";

  # Brightness
  brightUp   = "spawn 'brightnessctl set 10%+'";
  brightDown = "spawn 'brightnessctl set 10%-'";
in
{
  xdg.configFile."river/init" = {
    force = true;
    executable = true;
    text = ''
      #!/usr/bin/env sh

      # Export session variables to systemd user environment
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river

      # ------------------------------------------------------------------ #
      # Night light
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod} N       spawn 'pkill gammastep; gammastep -O 4500'
      riverctl map normal ${mod}+Shift N spawn 'pkill gammastep'

      # ------------------------------------------------------------------ #
      # Keyboard repeat rate
      # ------------------------------------------------------------------ #
      riverctl set-repeat 50 200

      # ------------------------------------------------------------------ #
      # Default behavior for new views
      # ------------------------------------------------------------------ #
      riverctl rule-add -app-id '*' no-float

      # ------------------------------------------------------------------ #
      # Applications
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod} Return spawn 'foot'
      riverctl map normal ${mod} D spawn 'tofi-run | xargs riverctl spawn'

      # ------------------------------------------------------------------ #
      # Close focused view
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod}+Shift Q close

      # ------------------------------------------------------------------ #
      # Focus views (vim-style)
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod} J focus-view left
      riverctl map normal ${mod} K focus-view down
      riverctl map normal ${mod} L focus-view up
      riverctl map normal ${mod} Semicolon focus-view right

      # Focus views (arrow keys)
      riverctl map normal ${mod} Left  focus-view left
      riverctl map normal ${mod} Down  focus-view down
      riverctl map normal ${mod} Up    focus-view up
      riverctl map normal ${mod} Right focus-view right

      # ------------------------------------------------------------------ #
      # Move views
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod}+Shift J swap left
      riverctl map normal ${mod}+Shift K swap down
      riverctl map normal ${mod}+Shift L swap up
      riverctl map normal ${mod}+Shift Semicolon swap right

      riverctl map normal ${mod}+Shift Left  swap left
      riverctl map normal ${mod}+Shift Down  swap down
      riverctl map normal ${mod}+Shift Up    swap up
      riverctl map normal ${mod}+Shift Right swap right

      # ------------------------------------------------------------------ #
      # Layout resize mode
      # ------------------------------------------------------------------ #
      riverctl declare-mode resize

      riverctl map normal ${mod} R enter-mode resize

      # Shrink main area
      riverctl map resize ${mod} H send-layout-cmd rivertile "main-ratio -0.05"

      # Grow main area
      riverctl map resize ${mod} L send-layout-cmd rivertile "main-ratio +0.05"

      # Increase number of main views
      riverctl map resize ${mod} K send-layout-cmd rivertile "main-count +1"

      # Decrease number of main views
      riverctl map resize ${mod} J send-layout-cmd rivertile "main-count -1"

      # Exit resize mode
      riverctl map resize None Escape enter-mode normal
      riverctl map resize None Return enter-mode normal 


      # ------------------------------------------------------------------ #
      # Fullscreen / floating
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod} F toggle-fullscreen
      riverctl map normal ${mod}+Shift Space toggle-float

      # ------------------------------------------------------------------ #
      # Tags (1–9)
      # ------------------------------------------------------------------ #
      for i in $(seq 1 9); do
        tags=$((1 << (i - 1)))
        riverctl map normal ${mod} "$i" set-focused-tags $tags
        riverctl map normal ${mod}+Shift "$i" set-view-tags $tags
      done

      # ------------------------------------------------------------------ #
      # Screenshots
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod} S spawn 'grim -g "$(slurp)" - | wl-copy'
      riverctl map normal None Print spawn 'grim - | wl-copy'

      # ------------------------------------------------------------------ #
      # Audio
      # ------------------------------------------------------------------ #
      riverctl map normal None XF86AudioRaiseVolume ${volUp}
      riverctl map normal None XF86AudioLowerVolume ${volDown}
      riverctl map normal None XF86AudioMute        ${volMute}

      # ------------------------------------------------------------------ #
      # Brightness
      # ------------------------------------------------------------------ #
      riverctl map normal None XF86MonBrightnessUp   ${brightUp}
      riverctl map normal None XF86MonBrightnessDown ${brightDown}

      # ------------------------------------------------------------------ #
      # Exit river
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod}+Shift E exit

      # ------------------------------------------------------------------ #
      # Mouse bindings
      # ------------------------------------------------------------------ #
      riverctl map-pointer normal ${mod} BTN_LEFT move-view
      riverctl map-pointer normal ${mod} BTN_RIGHT resize-view

      # ------------------------------------------------------------------ #
      # Cursor behavior
      # ------------------------------------------------------------------ #
      riverctl set-cursor-warp disabled

      # ------------------------------------------------------------------ #
      # Keyboard layout
      # ------------------------------------------------------------------ #
      riverctl keyboard-layout -options "grp:win_space_toggle" "us,es"

      # ------------------------------------------------------------------ #
      # Appearance
      # ------------------------------------------------------------------ #
      riverctl background-color 0x111111
      riverctl border-width 2

      # Neutral/default-like borders
      riverctl border-color-focused 0x93a1a1
      riverctl border-color-unfocused 0x586e75
      riverctl border-color-urgent 0xcb4b16 

      # ------------------------------------------------------------------ #
      # Layout generator
      # ------------------------------------------------------------------ #
      rivertile -view-padding 4 -outer-padding 4 &
      riverctl default-layout rivertile

      # ------------------------------------------------------------------ #
      # Autostart
      # ------------------------------------------------------------------ #
      mako &
      nm-applet --indicator &
      udiskie --no-automount --tray &
    '';
  };

  home.packages = with pkgs; [
    river-classic
    brightnessctl
    networkmanagerapplet
    grim
    slurp
    wl-clipboard
    tofi
    mako
    gammastep
  ];
}
