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

      # ------------------------------------------------------------ #
      # Environment
      # ------------------------------------------------------------ #
      dbus-update-activation-environment --systemd \
        WAYLAND_DISPLAY \
        XDG_CURRENT_DESKTOP=river

      riverctl set-repeat 50 200

      # REQUIRED: server-side decorations for tiling stability
      riverctl rule-add ssd

      # ------------------------------------------------------------ #
      # Layout engine (rivercarro)
      # ------------------------------------------------------------ #
      riverctl default-layout rivercarro

      rivercarro \
        -outer-gaps 0 \
        -inner-gaps 4 \
        -per-tag &

      # ------------------------------------------------------------ #
      # Launchers
      # ------------------------------------------------------------ #
      riverctl map normal ${mod} Return spawn 'foot'
      riverctl map normal ${mod} D spawn 'tofi-run | xargs riverctl spawn'

      # ------------------------------------------------------------ #
      # Close / window control
      # ------------------------------------------------------------ #
      riverctl map normal ${mod}+Shift Q close
      riverctl map normal ${mod} F toggle-fullscreen
      riverctl map normal ${mod}+Shift Space toggle-float

      # ------------------------------------------------------------ #
      # Focus movement
      # ------------------------------------------------------------ #
      riverctl map normal ${mod} J focus-view left
      riverctl map normal ${mod} K focus-view down
      riverctl map normal ${mod} L focus-view up
      riverctl map normal ${mod} Semicolon focus-view right

      riverctl map normal ${mod} Left  focus-view left
      riverctl map normal ${mod} Down  focus-view down
      riverctl map normal ${mod} Up    focus-view up
      riverctl map normal ${mod} Right focus-view right

      # ------------------------------------------------------------ #
      # Swap movement
      # ------------------------------------------------------------ #
      riverctl map normal ${mod}+Shift J swap left
      riverctl map normal ${mod}+Shift K swap down
      riverctl map normal ${mod}+Shift L swap up
      riverctl map normal ${mod}+Shift Semicolon swap right

      riverctl map normal ${mod}+Shift Left  swap left
      riverctl map normal ${mod}+Shift Down  swap down
      riverctl map normal ${mod}+Shift Up    swap up
      riverctl map normal ${mod}+Shift Right swap right

      # ------------------------------------------------------------ #
      # Layout control (rivercarro)
      # ------------------------------------------------------------ #

      # Resize main ratio (like width of master area)
      riverctl map normal ${mod} H send-layout-cmd rivercarro "main-ratio -0.05"
      riverctl map normal ${mod} L send-layout-cmd rivercarro "main-ratio +0.05"

      # Main count (number of master windows)
      riverctl map normal ${mod}+Shift H send-layout-cmd rivercarro "main-count +1"
      riverctl map normal ${mod}+Shift L send-layout-cmd rivercarro "main-count -1"

      # Layout orientation
      riverctl map normal ${mod} Up    send-layout-cmd rivercarro "main-location top"
      riverctl map normal ${mod} Right send-layout-cmd rivercarro "main-location right"
      riverctl map normal ${mod} Down  send-layout-cmd rivercarro "main-location bottom"
      riverctl map normal ${mod} Left  send-layout-cmd rivercarro "main-location left"

      # Monocle mode
      riverctl map normal ${mod} M send-layout-cmd rivercarro "main-location monocle"

      # Cycle layouts
      riverctl map normal ${mod} W send-layout-cmd rivercarro "main-location-cycle left,monocle,top,right,bottom"

      # ------------------------------------------------------------ #
      # Resize mode (no conflicts with layout engine)
      # ------------------------------------------------------------ #
      riverctl declare-mode resize
      riverctl map normal ${mod} R enter-mode resize

      riverctl map resize ${mod} H send-layout-cmd rivercarro "main-ratio -0.05"
      riverctl map resize ${mod} L send-layout-cmd rivercarro "main-ratio +0.05"

      riverctl map resize ${mod} K send-layout-cmd rivercarro "main-count +1"
      riverctl map resize ${mod} J send-layout-cmd rivercarro "main-count -1"

      riverctl map resize None Escape enter-mode normal
      riverctl map resize None Return enter-mode normal

      # ------------------------------------------------------------ #
      # Tags (workspaces)
      # ------------------------------------------------------------ #
      for i in $(seq 1 9); do
        tags=$((1 << (i - 1)))
        riverctl map normal ${mod} "$i" set-focused-tags $tags
        riverctl map normal ${mod}+Shift "$i" set-view-tags $tags
      done

      # ------------------------------------------------------------ #
      # Screenshots
      # ------------------------------------------------------------ #
      riverctl map normal ${mod} S spawn 'grim -g "$(slurp)" - | wl-copy'
      riverctl map normal None Print spawn 'grim - | wl-copy'

      # ------------------------------------------------------------ #
      # Audio
      # ------------------------------------------------------------ #
      riverctl map normal None XF86AudioRaiseVolume ${volUp}
      riverctl map normal None XF86AudioLowerVolume ${volDown}
      riverctl map normal None XF86AudioMute ${volMute}

      # ------------------------------------------------------------ #
      # Brightness
      # ------------------------------------------------------------ #
      riverctl map normal None XF86MonBrightnessUp ${brightUp}
      riverctl map normal None XF86MonBrightnessDown ${brightDown}

      # ------------------------------------------------------------ #
      # Exit
      # ------------------------------------------------------------ #
      riverctl map normal ${mod}+Shift E exit

      # ------------------------------------------------------------ #
      # Mouse
      # ------------------------------------------------------------ #
      riverctl map-pointer normal ${mod} BTN_LEFT move-view
      riverctl map-pointer normal ${mod} BTN_RIGHT resize-view

      riverctl set-cursor-warp disabled

      # ------------------------------------------------------------ #
      # Keyboard layout
      # ------------------------------------------------------------ #
      riverctl keyboard-layout -options "grp:win_space_toggle" "us,es"

      # ------------------------------------------------------------ #
      # Appearance
      # ------------------------------------------------------------ #
      riverctl background-color 0x111111

      # ------------------------------------------------------------ #
      # Autostart
      # ------------------------------------------------------------ #
      mako &
      nm-applet --indicator &
      udiskie --no-automount --tray &
    '';
  };

  home.packages = with pkgs; [
    rivercarro
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
