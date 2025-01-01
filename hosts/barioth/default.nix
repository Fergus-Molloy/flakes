{ inputs, ... }:
let
  host = "barioth";
in
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./services.nix
    ./packages.nix
    ../../modules/desktop-environments/hyprland.nix
    ../../modules/steam.nix
    ../../modules/nvidia.nix
  ];

  system.stateVersion = "24.11"; # Did you read the comment?

  services.xserver.videoDrivers = [ "nvidia" ];

  # set freq govenor 
  # "performance" - max speed all the time
  # "powersave" - min speed all the time
  # "ondemand" - scale speed based on load
  # "conservative" - scale speed but in increments rather than big jumps
  # "schedutil" - scale speed based on kernel scheduler
  powerManagement.cpuFreqGovernor = "schedutil";

  networking = {
    hostName = "${host}";

    networkmanager.enable = true;

    firewall.allowedTCPPorts = [
      2049 # nfs
    ];
    extraHosts = ''
      192.168.0.2 rathalos
    '';
  };

  # keep time the same as windows
  time.hardwareClockInLocalTime = true;
}
