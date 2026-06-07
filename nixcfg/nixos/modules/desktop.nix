{ pkgs, ... }:

{
  ### =============================================
  ### DISPLAY MANAGER
  ### =============================================
  services.displayManager.ly.enable = true;

  ### =============================================
  ### COMPOSITORS / WINDOW MANAGERS
  ### =============================================
  # Enable only what you want to use.
  # Both can be enabled at the same time if you want to choose at login with Ly.

  # --- Niri (Wayland) ---
  #programs.niri.enable = true;

  # --- i3 (X11) ---
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    windowManager.i3.package = pkgs.i3;
  };

  programs.xwayland.enable = true;

  ### =============================================
  ### PORTALS
  ### =============================================
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      #xdg-desktop-portal-gnome
    ];
    config.common.default = [ "gnome" ];
  };

  programs.dconf.enable = true;

  ### =============================================
  ### WAYLAND / SESSION VARIABLES
  ### =============================================
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    # XDG_CURRENT_DESKTOP will be set automatically by the compositor
  };

  ### =============================================
  ### LOGIN BEHAVIOR
  ### =============================================
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };
}
