{ pkgs, user, ... }: {
  imports = [
    ../../modules/qbittorrent.nix
    ./wireguard.nix
  ];

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg

    caddy
    wireguard-tools
  ];
  # enable mullvad daemon
  services.mullvad-vpn.enable = true;

  services.qbittorrent.enable = false;
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
  services.caddy = {
    enable = true;
    virtualHosts."molloy.xyz".extraConfig = ''
      respond "Hello"
    '';
    virtualHosts."fergus.molloy.xyz".extraConfig = ''
      respond "Hello from fergus"
    '';
    virtualHosts."10.0.0.1".extraConfig = ''
      respond "Hello from fergus"
    '';
  };

  services.ddclient = {
    enable = true;
    # contains sensitive api key see for setup: https://www.namecheap.com/support/knowledgebase/article.aspx/583/11/how-do-i-configure-ddclient/
    configFile = "/home/fergus/Documents/ddclient/config";
  };

  services.fail2ban = {
    enable = true;
  };

  services.tailscale = {
    enable = false;
    openFirewall = true;
  };
}
