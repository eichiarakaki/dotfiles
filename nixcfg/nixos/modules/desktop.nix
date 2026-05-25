{ pkgs, ... }:

{
  # River — Wayland compositor
  programs.river-classic = {
    enable          = true;
    xwayland.enable = true;
    package         = pkgs.river;
  };

  services.displayManager.ly.enable = true;

  xdg.portal = {
    enable       = true;
    wlr.enable   = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common.default = "wlr";
  };

  programs.dconf.enable = true;

  # Renamed options in nixos-unstable
  services.logind.settings.Login = {
    HandleLidSwitch              = "ignore";
    HandleLidSwitchDocked        = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };

  # Wayland session variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL      = "1";
    MOZ_ENABLE_WAYLAND  = "1";
    QT_QPA_PLATFORM     = "wayland";
    SDL_VIDEODRIVER     = "wayland";
    CLUTTER_BACKEND     = "wayland";
    XDG_SESSION_TYPE    = "wayland";
    XDG_CURRENT_DESKTOP = "river";
  };
}
