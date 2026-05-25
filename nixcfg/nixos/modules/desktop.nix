{ pkgs, ... }:

{
  # River es un compositor Wayland puro — no necesitamos Xserver
  programs.river = {
    enable      = true;
    xwayland.enable = true; # compatibilidad para apps X11 legacy
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

  services.logind = {
    lidSwitch              = "ignore";
    lidSwitchDocked        = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  # Variables de entorno Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL  = "1";   # apps Electron usen Wayland
    MOZ_ENABLE_WAYLAND = "1"; # Firefox nativo Wayland
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "river";
  };
}