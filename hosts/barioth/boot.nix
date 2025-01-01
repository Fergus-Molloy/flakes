{ ... }: {
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
    options = [ "x-systemd.automount" "noauto" ];
  };
}
