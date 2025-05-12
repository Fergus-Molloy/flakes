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
    secureBoot = true;
    # windows doesn't work with secure boot enabled
    # windows = {
    #   "11-win" = {
    #     title = "Window 11";
    #     efiDeviceHandle = "HD1b";
    #   };
    # };
  };

  system.stateVersion = "24.11"; # Did you read the comment?

  # keep time the same as windows
  time.hardwareClockInLocalTime = true;
}
