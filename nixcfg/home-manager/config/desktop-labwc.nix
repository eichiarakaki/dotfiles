{ config, pkgs, ... }:

let
  mkTrafficSvg = color: ''
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
      <circle cx="8" cy="8" r="5.6" fill="#${color}"/>
    </svg>
  '';

  closeSvg = mkTrafficSvg "ff3334";
  maxSvg = mkTrafficSvg "9ec400";
  inactiveSvg = mkTrafficSvg "666666";
in
{
  imports = [
    ./ghostty.nix
    ./fuzzel.nix
  ];

  home.packages = with pkgs; [
    # Window manager
    labwc

    # Notifications
    mako
    libnotify

    # Clipboard
    wl-clipboard
    cliphist

    # Screenshots
    grim
    slurp

    # Audio / media
    pavucontrol
    playerctl

    # Brightness / night mode
    brightnessctl
    gammastep

    # Auth agent
    polkit_gnome

    # Wayland utilities
    wlr-randr
    wev

    # XWayland keyboard repeat
    xorg.xset
  ];

  ### =============================================
  ### GTK / CSD BUTTON LAYOUT
  ### =============================================
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      # No minimize button. Minimize/iconify is bad without a taskbar.
      button-layout = "close,maximize:";
    };
  };

  ### =============================================
  ### LABWC ENVIRONMENT
  ### =============================================
  xdg.configFile."labwc/environment".text = ''
    XDG_CURRENT_DESKTOP=wlroots
    XDG_SESSION_DESKTOP=labwc
    XDG_SESSION_TYPE=wayland

    NIXOS_OZONE_WL=1
    MOZ_ENABLE_WAYLAND=1

    XCURSOR_SIZE=24

    XKB_DEFAULT_LAYOUT=us,es
  	XKB_DEFAULT_OPTIONS=grp:win_space_toggle
  '';

  ### =============================================
  ### LABWC AUTOSTART
  ### =============================================
  xdg.configFile."labwc/autostart" = {
    executable = true;
    text = ''
      #!/bin/sh

      systemctl --user import-environment \
        DISPLAY \
        WAYLAND_DISPLAY \
        XDG_CURRENT_DESKTOP \
        XDG_SESSION_DESKTOP \
        XDG_SESSION_TYPE \
        XCURSOR_SIZE \
        NIXOS_OZONE_WL \
        MOZ_ENABLE_WAYLAND

      dbus-update-activation-environment --systemd \
        DISPLAY \
        WAYLAND_DISPLAY \
        XDG_CURRENT_DESKTOP \
        XDG_SESSION_DESKTOP \
        XDG_SESSION_TYPE \
        XCURSOR_SIZE \
        NIXOS_OZONE_WL \
        MOZ_ENABLE_WAYLAND

      # XWayland keyboard repeat.
      # Native Wayland repeat is handled in rc.xml.
      ${pkgs.xorg.xset}/bin/xset r rate 200 40 2>/dev/null || true

      # GTK/CSD titlebar buttons to the left.
      # No minimize because minimized windows are annoying without a taskbar.
      ${pkgs.glib}/bin/gsettings set org.gnome.desktop.wm.preferences button-layout 'close,maximize:' &

      # Notifications
      mako &

      # Clipboard history
      wl-paste --type text --watch cliphist store &
      wl-paste --type image --watch cliphist store &

      # Polkit auth agent
      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
    '';
  };

  ### =============================================
  ### LABWC MENU
  ### =============================================
  xdg.configFile."labwc/menu.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <openbox_menu xmlns="http://openbox.org/3.4/menu">
      <menu id="root-menu" label="labwc">
        <item label="Terminal">
          <action name="Execute">
            <command>ghostty</command>
          </action>
        </item>

        <item label="Run">
          <action name="Execute">
            <command>fuzzel</command>
          </action>
        </item>

        <menu id="client-list-combined-menu" label="Windows" />

        <separator />

        <item label="Reload">
          <action name="Reconfigure" />
        </item>

        <item label="Exit">
          <action name="Exit" />
        </item>
      </menu>
    </openbox_menu>
  '';

  ### =============================================
  ### LABWC RC.XML
  ### =============================================
  xdg.configFile."labwc/rc.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <labwc_config>

      <core>
        <decoration>server</decoration>
        <gap>6</gap>
        <adaptiveSync>no</adaptiveSync>
      </core>

      <focus>
        <focusNew>yes</focusNew>
        <followMouse>no</followMouse>
        <focusLast>yes</focusLast>
        <underMouse>no</underMouse>
      </focus>

      <theme>
        <name>Scalith-dark</name>
        <cornerRadius>8</cornerRadius>
        <keepBorder>yes</keepBorder>

        <!-- Actions on the left. No minimize/iconify. -->
        <titlebar>
          <layout>close,max:</layout>
        </titlebar>

        <font place="ActiveWindow">
          <name>Iosevka</name>
          <size>10</size>
        </font>

        <font place="InactiveWindow">
          <name>Iosevka</name>
          <size>10</size>
        </font>

        <font place="MenuItem">
          <name>Iosevka</name>
          <size>10</size>
        </font>
      </theme>

      <desktops>
        <number>10</number>

        <!-- Disable workspace switcher popup completely. -->
        <popupTime>0</popupTime>

        <names>
          <name>1</name>
          <name>2</name>
          <name>3</name>
          <name>4</name>
          <name>5</name>
          <name>6</name>
          <name>7</name>
          <name>8</name>
          <name>9</name>
          <name>10</name>
        </names>
      </desktops>

      <keyboard>
        <default />

        <!-- Native Wayland keyboard repeat -->
        <repeatRate>40</repeatRate>
        <repeatDelay>200</repeatDelay>

        <!-- Terminal -->
        <keybind key="W-Return">
          <action name="Execute">
            <command>ghostty</command>
          </action>
        </keybind>

        <!-- Launcher -->
        <keybind key="W-d">
          <action name="Execute">
            <command>fuzzel</command>
          </action>
        </keybind>

        <!-- Clipboard history -->
        <keybind key="W-c">
          <action name="Execute">
            <command>sh -c 'cliphist list | fuzzel --dmenu | cliphist decode | wl-copy'</command>
          </action>
        </keybind>

        <!-- Close window -->
        <keybind key="W-q">
          <action name="Close" />
        </keybind>

        <!-- Hide-ish: send behind other windows, still reachable with window cycling -->
        <keybind key="W-z">
          <action name="Lower" />
        </keybind>

        <!-- Fallback window list -->
        <keybind key="W-w">
          <action name="ShowMenu">
            <menu>client-list-combined-menu</menu>
          </action>
        </keybind>

        <!-- Root menu -->
        <keybind key="W-S-space">
          <action name="ShowMenu">
            <menu>root-menu</menu>
          </action>
        </keybind>

        <!-- Reload -->
        <keybind key="W-r">
          <action name="Reconfigure" />
        </keybind>

        <!-- Exit -->
        <keybind key="W-S-e">
          <action name="Exit" />
        </keybind>

        <!-- Window cycling -->
        <keybind key="W-Tab">
          <action name="NextWindow" />
        </keybind>

        <keybind key="W-S-Tab">
          <action name="PreviousWindow" />
        </keybind>

        <!-- Fullscreen / maximize / decorations -->
        <keybind key="W-f">
          <action name="ToggleFullscreen" />
        </keybind>

        <keybind key="W-m">
          <action name="ToggleMaximize" />
        </keybind>

        <keybind key="W-v">
          <action name="ToggleDecorations" />
        </keybind>

        <!-- Snap workflow -->
        <keybind key="W-Left">
          <action name="ToggleSnapToEdge">
            <direction>left</direction>
          </action>
        </keybind>

        <keybind key="W-Right">
          <action name="ToggleSnapToEdge">
            <direction>right</direction>
          </action>
        </keybind>

        <keybind key="W-Up">
          <action name="ToggleMaximize" />
        </keybind>

        <keybind key="W-Down">
          <action name="Unmaximize" />
        </keybind>

        <!-- Move window to screen edges -->
        <keybind key="W-S-Left">
          <action name="MoveToEdge">
            <direction>left</direction>
          </action>
        </keybind>

        <keybind key="W-S-Right">
          <action name="MoveToEdge">
            <direction>right</direction>
          </action>
        </keybind>

        <keybind key="W-S-Up">
          <action name="MoveToEdge">
            <direction>up</direction>
          </action>
        </keybind>

        <keybind key="W-S-Down">
          <action name="MoveToEdge">
            <direction>down</direction>
          </action>
        </keybind>

        <!-- Screenshot selection to clipboard -->
        <keybind key="W-s">
          <action name="Execute">
            <command>sh -c 'grim -g "$(slurp)" - | wl-copy'</command>
          </action>
        </keybind>

        <!-- Quick status -->
        <keybind key="W-i">
          <action name="Execute">
            <command>sh -c 'notify-send "status" "$(date "+%Y-%m-%d %H:%M")\n$(wpctl get-volume @DEFAULT_AUDIO_SINK@)\n$(free -h | awk "/Mem:/ {print \"mem \" \$3 \"/\" \$2}")"'</command>
          </action>
        </keybind>

        <!-- Night mode -->
        <keybind key="W-n">
          <action name="Execute">
            <command>sh -c 'pkill gammastep; gammastep -O 3500'</command>
          </action>
        </keybind>

        <keybind key="W-S-n">
          <action name="Execute">
            <command>pkill gammastep</command>
          </action>
        </keybind>

        <!-- Workspaces -->
        <keybind key="W-1"><action name="GoToDesktop"><to>1</to></action></keybind>
        <keybind key="W-2"><action name="GoToDesktop"><to>2</to></action></keybind>
        <keybind key="W-3"><action name="GoToDesktop"><to>3</to></action></keybind>
        <keybind key="W-4"><action name="GoToDesktop"><to>4</to></action></keybind>
        <keybind key="W-5"><action name="GoToDesktop"><to>5</to></action></keybind>
        <keybind key="W-6"><action name="GoToDesktop"><to>6</to></action></keybind>
        <keybind key="W-7"><action name="GoToDesktop"><to>7</to></action></keybind>
        <keybind key="W-8"><action name="GoToDesktop"><to>8</to></action></keybind>
        <keybind key="W-9"><action name="GoToDesktop"><to>9</to></action></keybind>
        <keybind key="W-0"><action name="GoToDesktop"><to>10</to></action></keybind>

        <keybind key="W-S-1"><action name="SendToDesktop"><to>1</to><follow>no</follow></action></keybind>
        <keybind key="W-S-2"><action name="SendToDesktop"><to>2</to><follow>no</follow></action></keybind>
        <keybind key="W-S-3"><action name="SendToDesktop"><to>3</to><follow>no</follow></action></keybind>
        <keybind key="W-S-4"><action name="SendToDesktop"><to>4</to><follow>no</follow></action></keybind>
        <keybind key="W-S-5"><action name="SendToDesktop"><to>5</to><follow>no</follow></action></keybind>
        <keybind key="W-S-6"><action name="SendToDesktop"><to>6</to><follow>no</follow></action></keybind>
        <keybind key="W-S-7"><action name="SendToDesktop"><to>7</to><follow>no</follow></action></keybind>
        <keybind key="W-S-8"><action name="SendToDesktop"><to>8</to><follow>no</follow></action></keybind>
        <keybind key="W-S-9"><action name="SendToDesktop"><to>9</to><follow>no</follow></action></keybind>
        <keybind key="W-S-0"><action name="SendToDesktop"><to>10</to><follow>no</follow></action></keybind>

        <!-- Audio -->
        <keybind key="XF86AudioRaiseVolume">
          <action name="Execute">
            <command>wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0</command>
          </action>
        </keybind>

        <keybind key="XF86AudioLowerVolume">
          <action name="Execute">
            <command>wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-</command>
          </action>
        </keybind>

        <keybind key="XF86AudioMute">
          <action name="Execute">
            <command>wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle</command>
          </action>
        </keybind>

        <keybind key="XF86AudioMicMute">
          <action name="Execute">
            <command>wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle</command>
          </action>
        </keybind>

        <!-- Media -->
        <keybind key="XF86AudioPlay">
          <action name="Execute">
            <command>playerctl play-pause</command>
          </action>
        </keybind>

        <keybind key="XF86AudioPrev">
          <action name="Execute">
            <command>playerctl previous</command>
          </action>
        </keybind>

        <keybind key="XF86AudioNext">
          <action name="Execute">
            <command>playerctl next</command>
          </action>
        </keybind>

        <!-- Brightness -->
        <keybind key="XF86MonBrightnessUp">
          <action name="Execute">
            <command>brightnessctl --class=backlight set +10%</command>
          </action>
        </keybind>

        <keybind key="XF86MonBrightnessDown">
          <action name="Execute">
            <command>brightnessctl --class=backlight set 10%-</command>
          </action>
        </keybind>
      </keyboard>

      <mouse>
        <default />

        <context name="Frame">
          <mousebind button="W-Left" action="Drag">
            <action name="Move" />
          </mousebind>

          <mousebind button="W-Right" action="Drag">
            <action name="Resize" />
          </mousebind>

          <mousebind button="W-Middle" action="Click">
            <action name="ToggleMaximize" />
          </mousebind>
        </context>

        <context name="Root">
          <mousebind button="Right" action="Press">
            <action name="ShowMenu">
              <menu>root-menu</menu>
            </action>
          </mousebind>
        </context>
      </mouse>

    </labwc_config>
  '';

  ### =============================================
  ### DARK LABWC THEME
  ### =============================================
  xdg.dataFile."themes/Scalith-dark/openbox-3/themerc".text = ''
    border.width: 1

    window.titlebar.padding.width: 6
    window.titlebar.padding.height: 4

    window.active.border.color: #666666
    window.inactive.border.color: #424242

    window.active.title.bg.color: #000000
    window.inactive.title.bg.color: #000000
    window.*.title.bg: Solid

    window.active.label.text.color: #eaeaea
    window.inactive.label.text.color: #666666
    window.label.text.justify: center

    window.button.width: 18
    window.button.height: 18
    window.button.spacing: 2

    window.button.hover.bg.color: #42424266
    window.button.hover.bg.corner-radius: 9

    window.active.button.close.unpressed.image.color: #ff3334
    window.active.button.max.unpressed.image.color: #9ec400

    window.inactive.button.close.unpressed.image.color: #666666
    window.inactive.button.max.unpressed.image.color: #666666

    menu.border.width: 1
    menu.border.color: #666666

    menu.items.bg.color: #000000
    menu.items.text.color: #eaeaea
    menu.items.active.bg.color: #424242
    menu.items.active.text.color: #eaeaea

    menu.items.padding.x: 10
    menu.items.padding.y: 6

    menu.separator.width: 1
    menu.separator.padding.width: 6
    menu.separator.padding.height: 3
    menu.separator.color: #424242

    # Modern dark OSD for window switcher only.
    # Workspace switcher popup is disabled via popupTime=0.
    osd.bg.color: #000000e6
    osd.border.color: #424242
    osd.border.width: 1
    osd.label.text.color: #eaeaea

    osd.window-switcher.style-classic.width: 520
    osd.window-switcher.style-classic.padding: 8

    osd.window-switcher.style-classic.item.padding.x: 12
    osd.window-switcher.style-classic.item.padding.y: 6

    osd.window-switcher.style-classic.item.active.border.width: 1
    osd.window-switcher.style-classic.item.active.border.color: #7aa6da
    osd.window-switcher.style-classic.item.active.bg.color: #424242

    osd.window-switcher.style-classic.item.icon.size: 18

    osd.window-switcher.preview.border.width: 1
    osd.window-switcher.preview.border.color: #7aa6da

    # Disable workspace boxes visually too.
    osd.workspace-switcher.boxes.width: 0
    osd.workspace-switcher.boxes.height: 0
    osd.workspace-switcher.boxes.border.width: 0

    snapping.overlay.region.bg.color: #7aa6da30
    snapping.overlay.edge.bg.color: #7aa6da30
    snapping.overlay.region.border.width: 1
    snapping.overlay.edge.border.width: 1
    snapping.overlay.region.border.color: #7aa6da
    snapping.overlay.edge.border.color: #7aa6da
  '';

  ### =============================================
  ### DARK TRAFFIC LIGHT BUTTONS
  ### =============================================

  xdg.dataFile."themes/Scalith-dark/openbox-3/close.svg".text = closeSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/close-active.svg".text = closeSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/close-inactive.svg".text = inactiveSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/close_hover.svg".text = closeSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/close_hover-active.svg".text = closeSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/close_hover-inactive.svg".text = inactiveSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/close_pressed.svg".text = mkTrafficSvg "d54e53";

  xdg.dataFile."themes/Scalith-dark/openbox-3/max.svg".text = maxSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/max-active.svg".text = maxSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/max-inactive.svg".text = inactiveSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/max_hover.svg".text = maxSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/max_hover-active.svg".text = maxSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/max_hover-inactive.svg".text = inactiveSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/max_pressed.svg".text = mkTrafficSvg "9ec400";

  xdg.dataFile."themes/Scalith-dark/openbox-3/max_toggled.svg".text = maxSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/max_toggled-active.svg".text = maxSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/max_toggled-inactive.svg".text = inactiveSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/max_toggled_hover.svg".text = maxSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/max_toggled_hover-active.svg".text = maxSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/max_toggled_hover-inactive.svg".text = inactiveSvg;
  xdg.dataFile."themes/Scalith-dark/openbox-3/max_toggled_pressed.svg".text = mkTrafficSvg "9ec400";

  ### =============================================
  ### MAKO
  ### =============================================
  xdg.configFile."mako/config".text = ''
    default-timeout=5000
    border-radius=8
    margin=10
    padding=12
    layer=overlay

    background-color=#000000ee
    text-color=#eaeaea
    border-color=#666666
    border-size=1
  '';

  ### =============================================
  ### SESSION VARIABLES
  ### =============================================
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "wlroots";
    XDG_SESSION_DESKTOP = "labwc";
    XDG_SESSION_TYPE = "wayland";

    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    XCURSOR_SIZE = "24";
  };
}
