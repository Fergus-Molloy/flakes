{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  desktops.hyprland.enable = true;

  roles.gaming = {
    enable = true;
    graphics = "amd";
  };
  roles.developer.enable = true;
  roles.streamer.enable = true;
  roles.vpn.enable = true;

  # NOTE: not boot.loader
  bootloader = {
    enable = true;
    secureBoot = false;
    # windows doesn't work with secure boot enabled
    windows = {
      "11-win" = {
        title = "Windows 11";
        efiDeviceHandle = "HD1b";
      };
    };
  };

  system.stateVersion = "25.05"; # Did you read the comment?

  # keep time the same as windows
  time.hardwareClockInLocalTime = true;
}
