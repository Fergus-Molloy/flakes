{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.roles.monero;
in
with lib;
{
  options.roles.monero = {
    enable = mkEnableOption "Monero node + mining";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      monero-gui
      p2pool
      librespot
    ];
    services.monero = {
      enable = true;
      extraConfig = ''
        # RPC configuration
        public-node=0                             # Advertise the RPC-restricted port over p2p peer list
        # rpc-restricted-bind-ip=0.0.0.0            # Bind restricted RPC to all interfaces
        # rpc-restricted-bind-port=18089            # Bind restricted RPC on custom port to differentiate from default unrestricted RPC (18081)
        # no-igd=1                                  # Disable UPnP port mapping

        # ZMQ configuration
        # zmq-pub=tcp://127.0.0.1:18083

        out-peers=128
        in-peers=512
        # add-priority-node=p2pmd.xmrvsbeast.com:18080
        # add-priority-node=nodes.hashvault.pro:18080
        # disable-dns-checkpoints=1

        # Block known-malicious nodes from a DNSBL
        enable-dns-blocklist=1
      '';
    };
  };
}
