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

  system.stateVersion = "24.11"; # Did you read the comment?

  # keep time the same as windows
  time.hardwareClockInLocalTime = true;
}
