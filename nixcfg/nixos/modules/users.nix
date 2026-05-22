{ ... }:

{
  users.users.ares = {
    isNormalUser = true;
    description  = "Ares";
    extraGroups  = [ "networkmanager" "wheel" "docker" "video" ];
    packages     = [];
  };

  nixpkgs.config.allowUnfree = true;
}
