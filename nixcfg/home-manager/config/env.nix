{ config, pkgs, lib, ... }:

let
  externalHDDUUID  = "d3d59702-c7b0-4654-ba29-256bb69310d6";
  externalHDDMount = "${config.home.homeDirectory}/media/external_hdd";
in
{
  home.sessionVariables = {
    MOZ_GTK_TITLEBAR_DECORATION = "client";

    EDITOR = "vim";

    EXTERNAL_HDD_UUID  = externalHDDUUID;
    EXTERNAL_HDD_MOUNT = externalHDDMount;

    # GPU offload helpers (used by nvidia-offload wrapper)
    # These are set here so shells and .desktop launchers inherit them
    __NV_PRIME_RENDER_OFFLOAD        = "1";
    __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
    __GLX_VENDOR_LIBRARY_NAME        = "nvidia";
    __VK_LAYER_NV_optimus            = "NVIDIA_only";
  };

  # Create the mount point directory on activation
  home.activation.createMediaDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${externalHDDMount}"
  '';

  # Mount external HDD as a user systemd service — cleaner than activation scripts
  systemd.user.services.mount-external-hdd = {
    Unit = {
      Description = "Mount external HDD by UUID";
      After       = [ "default.target" ];
    };

    Service = {
      Type      = "oneshot";
      ExecStart = pkgs.writeShellScript "mount-external-hdd" ''
        MOUNT_POINT="${externalHDDMount}"
        DEVICE="/dev/disk/by-uuid/${externalHDDUUID}"

        if [ -b "$DEVICE" ] && ! mountpoint -q "$MOUNT_POINT"; then
          ${pkgs.util-linux}/bin/mount "$DEVICE" "$MOUNT_POINT" \
            || echo "Warning: could not mount external HDD"
        fi
      '';
      RemainAfterExit = true;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
