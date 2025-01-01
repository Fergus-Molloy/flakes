{ pkgs, user, ... }: {
  imports = [
    ../../modules/qbittorrent.nix
  ];

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
  # enable mullvad daemon
  services.mullvad-vpn.enable = true;

  services.qbittorrent.enable = true;
  users.groups."qbittorrent".members = [ "jellyfin" ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  users.groups."jellyfin".members = [ "sonarr" "radarr" ];

  services.sonarr = {
    enable = true;
    openFirewall = true;
  };
  services.radarr = {
    enable = true;
    openFirewall = true;
  };
  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };
}
