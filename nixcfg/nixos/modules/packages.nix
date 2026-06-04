{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Base
    wget
    git
    cacert

    # Browser
    firefox

    # Terminal
    #foot

    # Filesystem
    btrfs-progs
    exfatprogs
    ntfs3g
    udiskie
    udisks2

    # D-Bus / desktop infra
    dbus
    dconf

    # Audio
    pipewire

    # OpenGL
    libGLU

    # Vulkan
    vulkan-loader
    vulkan-tools
  ];
}
