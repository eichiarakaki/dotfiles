{ pkgs, ... }:

{
  # PRIME Offload: Intel maneja el display de la laptop,
  # NVIDIA se activa on-demand con `nvidia-offload <cmd>`
  hardware.graphics = {
    enable      = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      mesa
      libglvnd
      libva
      libvdpau
      nvidia-vaapi-driver
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      enable      = true;
      finegrained = true; # RTX se apaga cuando no se usa — ahorra batería
    };

    open = false;

    nvidiaSettings = true;

    prime = {
      offload = {
        enable           = true;
        enableOffloadCmd = true; # agrega el comando `nvidia-offload`
      };

      intelBusId  = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Requerido también en Wayland para que el driver NVIDIA sea cargado
  services.xserver.videoDrivers = [ "nvidia" ];

  environment.variables = {
    LIBGL_DRIVERS_PATH = "/run/opengl-driver/lib/dri";
    # Necesario para NVIDIA + wlroots (River): evita crash de cursores HW
    #WLR_NO_HARDWARE_CURSORS = "1";
  };
}
