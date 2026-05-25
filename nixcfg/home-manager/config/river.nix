{ config, pkgs, lib, ... }:

let
  mod = "Super";

  # wpctl shortcuts
  volUp   = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
  volDown = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
  volMute = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

  # Brightness
  brightUp   = "exec brightnessctl set 10%+";
  brightDown = "exec brightnessctl set 10%-";

  # Screenshot: select region → copy to clipboard
  screenshot     = "exec grim -g \"$(slurp)\" - | wl-copy";
  screenshotFull = "exec grim - | wl-copy";
in
{
  # River is configured via an executable init script
  xdg.configFile."river/init" = {
    force = true;
    executable = true;
    text = ''
      #!/usr/bin/env sh
      
      # Export session vars to systemd user environment
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river


      # ------------------------------------------------------------------ #
      # Keyboard repeat rate (equivalent to xset r rate 200 50)
      # ------------------------------------------------------------------ #
      riverctl set-repeat 50 200

      # ------------------------------------------------------------------ #
      # Applications
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod} Return spawn foot
      riverctl map normal ${mod} D spawn 'tofi-run | xargs riverctl spawn'

      # ------------------------------------------------------------------ #
      # Kill focused view
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod}+Shift Q close

      # ------------------------------------------------------------------ #
      # Focus windows — vim-style
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod} J focus-view left
      riverctl map normal ${mod} K focus-view down
      riverctl map normal ${mod} L focus-view up
      riverctl map normal ${mod} Semicolon focus-view right

      # Focus windows — arrows
      riverctl map normal ${mod} Left  focus-view left
      riverctl map normal ${mod} Down  focus-view down
      riverctl map normal ${mod} Up    focus-view up
      riverctl map normal ${mod} Right focus-view right

      # ------------------------------------------------------------------ #
      # Move windows — vim-style
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod}+Shift J swap left
      riverctl map normal ${mod}+Shift K swap down
      riverctl map normal ${mod}+Shift L swap up
      riverctl map normal ${mod}+Shift Semicolon swap right

      # Move windows — arrows
      riverctl map normal ${mod}+Shift Left  swap left
      riverctl map normal ${mod}+Shift Down  swap down
      riverctl map normal ${mod}+Shift Up    swap up
      riverctl map normal ${mod}+Shift Right swap right

      # ------------------------------------------------------------------ #
      # Resize mode (equivalent to i3 resize mode)
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod} R enter-mode resize

      riverctl map resize ${mod} J resize horizontal -100
      riverctl map resize ${mod} K resize vertical    100
      riverctl map resize ${mod} L resize vertical   -100
      riverctl map resize ${mod} Semicolon resize horizontal 100

      riverctl map resize ${mod} Left  resize horizontal -100
      riverctl map resize ${mod} Down  resize vertical    100
      riverctl map resize ${mod} Up    resize vertical   -100
      riverctl map resize ${mod} Right resize horizontal  100

      riverctl map resize None Return enter-mode normal
      riverctl map resize None Escape enter-mode normal

      # ------------------------------------------------------------------ #
      # Fullscreen toggle  (equivalent to i3 fullscreen toggle)
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod} F toggle-fullscreen

      # ------------------------------------------------------------------ #
      # Floating toggle  (equivalent to i3 floating toggle)
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod}+Shift Space toggle-float

      # ------------------------------------------------------------------ #
      # Layout: horizontal / vertical split (rivertile main-ratio)
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod} H send-layout-cmd rivertile "main-ratio -0.05"
      riverctl map normal ${mod} V send-layout-cmd rivertile "main-ratio +0.05"

      # ------------------------------------------------------------------ #
      # Workspaces 1–9  (tags in River = bitmask)
      # ------------------------------------------------------------------ #
      for i in $(seq 1 9); do
        tags=$((1 << (i - 1)))
        riverctl map normal ${mod}       "$(($i))" set-focused-tags $tags
        riverctl map normal ${mod}+Shift "$(($i))" set-view-tags    $tags
      done

      # ------------------------------------------------------------------ #
      # Screenshots
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod}       S ${screenshot}
      riverctl map normal None         Print ${screenshotFull}

      # ------------------------------------------------------------------ #
      # Audio
      # ------------------------------------------------------------------ #
      riverctl map normal None XF86AudioRaiseVolume  ${volUp}
      riverctl map normal None XF86AudioLowerVolume  ${volDown}
      riverctl map normal None XF86AudioMute         ${volMute}

      # ------------------------------------------------------------------ #
      # Brightness
      # ------------------------------------------------------------------ #
      riverctl map normal None XF86MonBrightnessUp   ${brightUp}
      riverctl map normal None XF86MonBrightnessDown ${brightDown}

      # ------------------------------------------------------------------ #
      # Quit River  (equivalent to i3 exit)
      # ------------------------------------------------------------------ #
      riverctl map normal ${mod}+Shift E exit

      # ------------------------------------------------------------------ #
      # Mouse: move and resize floating views with Super held
      # ------------------------------------------------------------------ #
      riverctl map-pointer normal ${mod} BTN_LEFT  move-view
      riverctl map-pointer normal ${mod} BTN_RIGHT resize-view

      # ------------------------------------------------------------------ #
      # Focus follows cursor — disabled (same as i3 followMouse false)
      # ------------------------------------------------------------------ #
      riverctl set-cursor-warp disabled

      # ------------------------------------------------------------------ #
      # Keyboard layout — us/es, toggle with Super+Space
      # ------------------------------------------------------------------ #
      riverctl keyboard-layout -options "grp:win_space_toggle" "us,es"

      # ------------------------------------------------------------------ #
      # Layout generator
      # ------------------------------------------------------------------ #
      rivertile -view-padding 4 -outer-padding 4 &

      # ------------------------------------------------------------------ #
      # Autostart
      # ------------------------------------------------------------------ #
      mako &
      nm-applet --indicator &
      udiskie --no-automount --tray &
    '';
  };

  home.packages = with pkgs; [
    river-classic  # river was renamed to river-classic in nixpkgs 25.05
    brightnessctl
    networkmanagerapplet
    grim
    slurp
    wl-clipboard
    tofi
    mako
  ];
}
