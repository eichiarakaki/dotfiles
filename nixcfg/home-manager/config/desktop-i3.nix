{ pkgs, ... }:

{
  imports = [
    ./alacritty.nix  
  ];
  
  home.packages = with pkgs; [
    dmenu
    dunst
    scrot
    xclip
    redshift
    pavucontrol
    brightnessctl
    xset
  ];

  # ======================== i3 ========================
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;

    config = rec {
      modifier = "Mod4";

      fonts = {
        names = [ "Iosevka" ];
        size = 10.0;
      };

      window = {
        border = 1;
        titlebar = true;
      };

      floating = {
        border = 1;
        titlebar = true;
      };

      focus.followMouse = false;

      keybindings = {
        # Terminal
        "${modifier}+Return" = "exec alacritty";

        # Launcher (dmenu)
        "${modifier}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";

        # Kill window
        "${modifier}+Shift+q" = "kill";


        "${modifier}+s" = "exec scrot -s";

        # Redshift / Gammastep
        "${modifier}+n" = "exec redshift -O 6000";
        "${modifier}+Shift+n" = "exec redshift -x";

        "${modifier}+space" = "exec setxkbmap -layout us,es -option grp:win_space_toggle";

        # Focus
        "${modifier}+j" = "focus left";
        "${modifier}+k" = "focus down";
        "${modifier}+l" = "focus up";
        "${modifier}+semicolon" = "focus right";

        "${modifier}+Left"  = "focus left";
        "${modifier}+Down"  = "focus down";
        "${modifier}+Up"    = "focus up";
        "${modifier}+Right" = "focus right";

        # Move windows
        "${modifier}+Shift+j" = "move left";
        "${modifier}+Shift+k" = "move down";
        "${modifier}+Shift+l" = "move up";
        "${modifier}+Shift+semicolon" = "move right";

        # Split
        "${modifier}+h" = "split h";
        "${modifier}+v" = "split v";

        # Layouts
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";

        # Fullscreen & Floating
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+Shift+space" = "floating toggle";
        #"${modifier}+space" = "focus mode_toggle";

        # Focus parent
        "${modifier}+a" = "focus parent";

        # Workspaces
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        # Move container to workspace
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        # Reload / Restart / Exit
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";
        "${modifier}+Shift+e" = "exec i3-nagbar -t warning -m 'Exit i3?' -b 'Yes' 'i3-msg exit'";

        # Resize mode
        "${modifier}+r" = "mode resize";

      };

      # ======================== Resize Mode ========================
      modes = {
        resize = {
          "j" = "resize shrink width 10 px or 10 ppt";
          "k" = "resize grow height 10 px or 10 ppt";
          "l" = "resize shrink height 10 px or 10 ppt";
          "semicolon" = "resize grow width 10 px or 10 ppt";

          "Left"  = "resize shrink width 10 px or 10 ppt";
          "Down"  = "resize grow height 10 px or 10 ppt";
          "Up"    = "resize shrink height 10 px or 10 ppt";
          "Right" = "resize grow width 10 px or 10 ppt";

          "Return" = "mode default";
          "Escape" = "mode default";
        };
      };

      # ======================== Bar (i3bar + i3status) ========================
      bars = [{
        statusCommand = "i3status";
        fonts = {
          names = [ "Iosevka" ];
          size = 10.0;
        };
      }];
    };
  
  # ======================== STARTUP ========================
    extraConfig = ''
      exec --no-startup-id xset r rate 200 40
      exec --no-startup-id pcmanfm --daemon-mode
    '';
  };

  # ======================== Dunst (Notificaciones) ========================
  services.dunst.enable = true;

  # Session variables
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "i3";
    XDG_SESSION_TYPE = "x11";
  };
}
