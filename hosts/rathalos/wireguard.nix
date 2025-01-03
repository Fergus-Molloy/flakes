{ config, pkgs, ... }:
let
  interface = "eno1";
in
{
  # enable NAT
  networking.nat.enable = true;
  networking.nat.externalInterface = interface;
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  networking.wireguard.enable = true;
  networking.wireguard.interfaces = {
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "10.0.0.1/24" "fdc9:281f:04d7:9ee9::1/64" ];

      listenPort = 51820;

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o ${interface} -j MASQUERADE
      '';

      # This undoes the above command
      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o ${interface} -j MASQUERADE
      '';

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/home/fergus/.wg/private";

      peers = [
        {
          name = "diablos";
          publicKey = "qtnMjNg+m7GNLREkblnqt/wbj5cpjoDLVGzolEFXXx0=";
          # List of IPs assigned to this peer within the tunnel subnet.
          allowedIPs = [ "10.0.0.2/32" "fdc9:281f:04d7:9ee9::2/128" ];
        }
        {
          name = "Pixel-8-Pro";
          publicKey = "rTkZjQ5M+oMoQpzEbCcvdBO2EyIUSEKfq/RBxldM1j8=";
          allowedIPs = [ "10.0.0.3/32" "fdc9:281f:04d7:9ee9::3/128" ];
        }
      ];
    };
  };
}

