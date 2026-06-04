{ ... }:

{
  services.pipewire = {
    enable       = true;
    alsa.enable  = true;
    pulse.enable = true;
    jack.enable  = true;
    wireplumber.enable = true;

    extraConfig.pipewire = {
      "99-disable-bell" = {
        "context.properties" = {
          "module.x11.bell" = false;
        };
      };
    };
  };
}
