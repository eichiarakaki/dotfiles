{ ... }:

{
  #networking.wireless.enable = false; # NetworkManager lo maneja
  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
}
