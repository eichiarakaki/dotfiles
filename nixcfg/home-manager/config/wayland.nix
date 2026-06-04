{ pkgs, ... }:

{
  # Screen locker — swaylock replaces i3lock under Wayland
  #programs.swaylock = {
  #  enable = true;
  #  settings = {
  #    color = "181818";
  #    show-failed-attempts = true;
  #  };
  #};

  # Clipboard manager — cliphist is the Wayland-native equivalent of clipmenu
  services.cliphist.enable = true;

  # Polkit agent — same agent, now launched as a Wayland-aware user service
  systemd.user.services.polkit-gnome = {
    Unit = {
      Description = "Polkit GNOME authentication agent";
      After  = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart   = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart     = "on-failure";
      RestartSec  = 1;
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };

  home.packages = with pkgs; [
    polkit_gnome
    wl-clipboard   # wl-copy / wl-paste (replaces xclip/xsel)
    #wlr-randr      # output management (replaces arandr)
  ];
}
