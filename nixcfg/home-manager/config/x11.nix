{ pkgs, ... }:

{
  #
  # Screen locker
  #
  programs.i3lock = {
    enable = true;
    package = pkgs.i3lock-color;
  };

  #
  # Clipboard manager
  #
  services.clipmenu.enable = true;

  #
  # Packages
  #
  home.packages = with pkgs; [
    polkit_gnome
    xdotool
    xclip
    xsel
    arandr
    feh
  ];

  #
  # Polkit agent
  #
  systemd.user.services.polkit-gnome = {
    Unit = {
      Description = "Polkit GNOME authentication agent";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart =
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";

      Restart = "on-failure";
      RestartSec = 1;
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}