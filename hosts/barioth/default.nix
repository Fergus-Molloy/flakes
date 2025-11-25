{ pkgs, ... }:
let
in
{
  imports = [
    ./hardware-configuration.nix
  ];
  services.btrfs.autoScrub.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  desktops.hyprland.enable = true;

  roles.ai = {
    enable = true;
    pkgOverride = pkgs.ollama-rocm;
  };
  roles.gaming = {
    enable = true;
    graphics = "amd";
    minecraft = true;
  };
  roles.developer = {
    enable = true;
    claude = true;
  };
  roles.streamer.enable = true;
  roles.vpn.enable = true;

  # NOTE: not boot.loader
  bootloader = {
    enable = true;
    secureBoot = true;
    plymouth = true;
    # windows doesn't work with secure boot enabled
    # enabled by copying \EFI\Microsoft into /boot/EFI/
    # windows = {
    #   "11-win" = {
    #     title = "Windows 11";
    #     efiDeviceHandle = "HD1b";
    #   };
    # };
  };

  share.enable = true;
  bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    obsidian
  ];

  system.stateVersion = "25.05"; # Did you read the comment?

  # keep time the same as windows
  time.hardwareClockInLocalTime = true;
}
