{ config, pkgs, ... }:
let
  interface = "wlon1";
  name = "wg0";
  port = 51820;
  ips = [ "10.0.0.2/24" "fdc9:281f:04d7:9ee9::2/64" ];
  privateKeyPath = "/home/fergus/.wg/private";
  peers = [
    # For a client configuration, one peer entry for the server will suffice.
    {
      # Public key of the server (not a file path).
      publicKey = "M8NUxRWtvXlo7rR2tgbEt+3RBVmEhKKoq5JDLviTNhA=";

      # Forward all the traffic via VPN.
      # for some reason this doesn't work? Works on android
      # allowedIPs = [ "0.0.0.0/0" "::/0" ];
      # Or forward only particular subnets
      allowedIPs = [ "10.0.0.1" "fdc9:281f:04d7:9ee9::1" ];

      endpoint = "molloy.xyz:51820";

      # Send keepalives every 25 seconds. Important to keep NAT tables alive.
      persistentKeepalive = 25;
      dynamicEndpointRefreshSeconds = 500;
    }
  ];
in
{
  environment.systemPackages = [ pkgs.wireguard-tools ];
  networking.firewall = {
    allowedUDPPorts = [ port ]; # Clients and peers can use the same port, see listenport
  };
  # Enable WireGuard
  networking.wireguard.enable = true;
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    "${name}" = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      ips = ips;
      listenPort = port; # to match firewall allowedUDPPorts (without this wg uses random port numbers)

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = privateKeyPath;

      peers = peers;
    };
  };
}