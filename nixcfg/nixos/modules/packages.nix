{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Base
    wget
    git
    cacert

    # Browser
    firefox

    # Filesystem
    btrfs-progs
    exfatprogs
    ntfs3g
    udiskie
    udisks2

    # Desktop
    dbus
    dconf
    pipewire

    # Graphics
    libGLU
    vulkan-loader
    vulkan-tools

    pcmanfm
    lxsession
  ];
}
