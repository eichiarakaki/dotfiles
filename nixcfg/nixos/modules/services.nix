{ pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.autoUpgrade = {
    enable      = true;
    allowReboot = true;
  };

  services.flatpak.enable = true;
  services.dbus.enable = true;
  #services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.gnome.gnome-keyring.enable = true;

  programs.nix-ld.enable = true;

  programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable          = true;
    enableSSHSupport = true;
  };


  # Quant
  fileSystems."/data/hdd" = {
    device = "/dev/disk/by-uuid/d3d59702-c7b0-4654-ba29-256bb69310d6";
    fsType = "ext4";

    options = [
      "nofail"
      "x-systemd.automount"
    ];
  };
  
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;

    dataDir = "/data/hdd/postgresql";
  };
}

