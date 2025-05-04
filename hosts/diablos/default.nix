# TODO: actually test this on diablos
{
  ...
}:
{
  imports = [
    ./backlight.nix
    ./hardware-configuration.nix
    ../../modules/desktop-environments/hyprland.nix
  ];

  roles.gaming = {
    enable = true;
    graphics = "nvidia";
  };
  roles.developer.enable = true;
  roles.vpn.enable = true;

  system.stateVersion = "24.11"; # Did you read the comment?

  powerManagement.cpuFreqGovernor = "conservative";

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.wireless.userControlled.enable = true;
  # to setup wifi do the following
  # $ wpa_cli
  # > scan
  # > scan_results
  # > add_network
  # > set_network 0 ssid "SSID"
  # > set_network 0 psk "password"
  # > enable_network 0
  # > save_config
  # we can now load this config after restarts with `wpa_supplicant -B -i wlo1 -c /run/wpa_supplicant/wpa_supplicant.conf`
}
