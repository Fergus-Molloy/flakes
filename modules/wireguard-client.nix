{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.wireguard;
in
{
  options.services.wireguard = {
    enable = mkEnableOption (mdDoc "wireguard client");

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = lib.mdDoc ''
        Open wireguard port to the outside network.
      '';
    };

    interface = mkOption {
      type = types.nonEmptyString;
      default = "wg0";
      example = "wg2";
      description = lib.mdDoc ''
        name of interfaces to use
      '';
    };

    ip = mkOption {
      type = types.ip;
      default = "10.100.0.2/24";
      example = "10.100.0.3/24";
      description = lib.mdDoc ''
        client ip to use
      '';
    };

    port = mkOption {
      type = types.port;
      default = 51820;
      example = 53;
      description = lib.mdDoc ''
        udp port to use
      '';
    };
    privateKeyFile = mkOption {
      type = types.path;
      default = "";
      example = "/home/jane/.wg/private";
      description = lib.mdDoc ''
        path to private key
      '';
    };

    server = {
      ip = mkOption {
        type = types.ip;
        default = "10.100.0.1";
        description = lib.mdDoc "server's ip";
      };
      port = mkOption {
        type = types.port;
        default = 51820;
        description = lib.mdDoc "server's port";
      };
      publicKey = mkOption {
        type = types.nonEmptyString;
        default = "";
        description = lib.mdDoc "server's public key";
      };
    };
  };

  config = mkIf cfg.enable {
    # enable NAT
    networking.nat.enable = true;
    networking.firewall = mkIf cfg.openFirewall {
      allowedUDPPorts = [ cfg.port ];
    };

    networking.wireguard.enable = true;
    networking.wireguard.interfaces = {
      "${cfg.interface}" = {
        # Determines the IP address and subnet of the clients's end of the tunnel interface.
        ips = [ cfg.ip ];

        listenPort = cfg.port;

        privateKeyFile = cfg.privateKeyFile;

        peers = [
          cfg.server // {
          persistentKeepalive = 25;
        }
        ];
      };
    };
  };
}
