{ inputs, pkgs, ... }:
let
  host = "barioth";
in
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./monitors.nix
    ../../modules/hyprland.nix
  ];

  roles.gaming.enable = true;
  roles.developer.enable = true;
  roles.vpn.enable = true;

  environment.systemPackages = with pkgs; [
    (wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    })
  ];

  system.stateVersion = "24.11"; # Did you read the comment?

  # keep time the same as windows
  time.hardwareClockInLocalTime = true;
}
