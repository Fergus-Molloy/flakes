{ config, ... }:
{

  # Bootloader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    useOSProber = true;
    efiSupport = true;
    configurationLimit = 10;
  };

  fileSystems."/mnt/share" = {
    device = "rathalos:/srv/nfs/share";
    fsType = "nfs";
    # mount only when we try to access the drive
    options = [
      "x-systemd.automount"
      "noauto"
    ];
  };

  # enable virtual camera
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;
}
