{ config, pkgs, lib, ... }:

let
  mod = "Mod4";
in
{
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = mod;

      terminal = "alacritty";

      fonts = {
        names = [ "Iosevka Nerd Font" ];
        size = 10.0;
      };

      floating.modifier = mod;

      focus = {
        followMouse = false;
      };

      window = {
        hideEdgeBorders = "both";
      };

      keybindings = lib.mkOptionDefault {
        #
        # Applications
        #
        "${mod}+Return" = "exec alacritty";
        "${mod}+d"      = "exec dmenu_run";

        #
        # Screenshots
        #
        "${mod}+s" = ''exec --no-startup-id scrot -s /tmp/screenshot.png -e 'xclip -selection clipboard -target image/png -i $f' '';
        "Print"    = ''exec --no-startup-id scrot /tmp/screenshot.png -e 'xclip -selection clipboard -target image/png -i $f' '';

        #
        # Kill window
        #
        "${mod}+Shift+q" = "kill";

        #
        # Focus windows (vim-style)
        #
        "${mod}+j"         = "focus left";
        "${mod}+k"         = "focus down";
        "${mod}+l"         = "focus up";
        "${mod}+semicolon" = "focus right";

        #
        # Focus windows (arrows)
        #
        "${mod}+Left"  = "focus left";
        "${mod}+Down"  = "focus down";
        "${mod}+Up"    = "focus up";
        "${mod}+Right" = "focus right";

        #
        # Move windows (vim-style)
        #
        "${mod}+Shift+j"         = "move left";
        "${mod}+Shift+k"         = "move down";
        "${mod}+Shift+l"         = "move up";
        "${mod}+Shift+semicolon" = "move right";

        #
        # Move windows (arrows)
        #
        "${mod}+Shift+Left"  = "move left";
        "${mod}+Shift+Down"  = "move down";
        "${mod}+Shift+Up"    = "move up";
        "${mod}+Shift+Right" = "move right";

        #
        # Layouts
        #
        "${mod}+h" = "split h";
        "${mod}+v" = "split v";

        "${mod}+f" = "fullscreen toggle";

        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";

        #
        # Floating
        #
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space"       = "focus mode_toggle";

        #
        # Parent container
        #
        "${mod}+a" = "focus parent";

        #
        # Reload / restart
        #
        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";

        #
        # Exit i3
        #
        "${mod}+Shift+e" =
          ''exec "i3-nagbar -t warning -m 'Exit i3?' -b 'Yes' 'i3-msg exit'"'';

        #
        # Resize mode
        #
        "${mod}+r" = ''mode "resize"'';

        #
        # Audio
        #
        "XF86AudioRaiseVolume" =
          "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";

        "XF86AudioLowerVolume" =
          "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";

        "XF86AudioMute" =
          "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

        #
        # Brightness
        #
        "XF86MonBrightnessUp" =
          "exec brightnessctl set 10%+";

        "XF86MonBrightnessDown" =
          "exec brightnessctl set 10%-";
      };

      modes = {
        resize = {
          j = "resize shrink width 10 px or 10 ppt";
          k = "resize grow height 10 px or 10 ppt";
          l = "resize shrink height 10 px or 10 ppt";
          semicolon = "resize grow width 10 px or 10 ppt";

          Left  = "resize shrink width 10 px or 10 ppt";
          Down  = "resize grow height 10 px or 10 ppt";
          Up    = "resize shrink height 10 px or 10 ppt";
          Right = "resize grow width 10 px or 10 ppt";

          Return = ''mode "default"'';
          Escape = ''mode "default"'';
        };
      };

      workspaceAutoBackAndForth = true;

      startup = [
        #
        # Faster keyboard repeat
        #
        {
          command = "xset r rate 200 50";
          notification = false;
          always = true;
        }

        #
        # Services
        #
        {
          command = "dunst";
          notification = false;
        }

        {
          command = "nm-applet";
          notification = false;
        }

        {
          command = "udiskie --tray";
          notification = false;
        }
      ];

      bars = [
        {
          statusCommand = "i3status";

          fonts = {
            names = [ "Iosevka Nerd Font" ];
            size = 10.0;
          };
        }
      ];
    };
  };

  home.packages = with pkgs; [
    brightnessctl
    networkmanagerapplet
  ];
}