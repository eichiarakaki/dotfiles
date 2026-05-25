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
    foot

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

    # Notifications (compatible Wayland)
    mako

    # River utilities
    wlr-randr    # gestión de outputs (equivalente a xrandr)
    wl-clipboard # wl-copy / wl-paste
    grim         # screenshots
    slurp        # selección de región para grim
    tofi         # app launcher Wayland (alternativa a dmenu/rofi)
  ];
}