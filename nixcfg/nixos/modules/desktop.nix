{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    dpi    = 96;

    windowManager.i3 = {
      enable  = true;
      package = pkgs.i3;
    };
  };

  services.displayManager.ly.enable = true;

  xdg.portal = {
    enable       = true;
    wlr.enable   = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  programs.dconf.enable = true;

  services.logind = {
    lidSwitch              = "ignore";
    lidSwitchDocked        = "ignore";
    lidSwitchExternalPower = "ignore";
  };
}
