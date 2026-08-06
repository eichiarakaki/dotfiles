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

    wireplumber.extraConfig = {
      # Keep Bluetooth headsets in A2DP (stereo, hi-fi) at all times.
      # Without this, WirePlumber auto-switches to HSP/HFP (mono,
      # low-bitrate telephone codec + extra latency) the moment any app
      # opens the headset's mic — e.g. Discord/Vesktop during a call —
      # which wrecked screen-share audio quality and added lag.
      # Use a non-Bluetooth mic (built-in or USB) for voice input instead.
      "51-disable-bluetooth-autoswitch" = {
        "wireplumber.settings" = {
          "bluetooth.autoswitch-to-headset-profile" = false;
        };
      };
    };
  };
}
