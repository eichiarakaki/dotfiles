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
    alacritty

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
    libglibutil

    # Vulkan
    vulkan-loader
    vulkan-tools

    # Notifications
    dunst

    # X11 init (útil para debug)
    xorg.xinit
  ];
}
