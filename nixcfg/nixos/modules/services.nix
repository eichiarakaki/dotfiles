{ ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.autoUpgrade = {
    enable      = true;
    allowReboot = true;
  };

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
}

