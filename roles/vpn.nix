{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.roles.vpn;
in
with lib;
{
  imports = [ ../modules/nvim.nix ];
  options.roles.vpn = {
    enable = mkEnableOption "Install vpn";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wireguard-tools
      (pkgs.writeShellScriptBin "vpn" ''
        #!/usr/bin/env bash
        # check user is root
        if [[ $EUID -ne 0 ]]; then
           echo "This script must be run as root" 
           exit 1
        fi

        # Initialize variables
        ACTION=""
        VPN_NAME=""
        DEFAULT_VPN="p-sweden"

        # Function to display usage
        usage() {
            echo "Usage: $0 [COMMAND] [VPN_NAME]"
            echo "Commands:"
            echo "  (no args)    Get VPN status"
            echo "  list         List available VPN connections"
            echo "  down         Disconnect from VPN"
            echo "  up           Connect to default VPN"
            echo "  up <name>    Connect to specific VPN"
            exit 1
        }

        # Parse command line arguments
        case $# in
            0)
                # No arguments - get status
                ACTION="status"
                ;;
            1)
                case $1 in
                    "list")
                        ACTION="list"
                        ;;
                    "down")
                        ACTION="down"
                        ;;
                    "up")
                        ACTION="up"
                        VPN_NAME="$DEFAULT_VPN"
                        ;;
                    "help"|"-h"|"--help")
                        usage
                        ;;
                    *)
                        echo "Error: Unknown command '$1'"
                        usage
                        ;;
                esac
                ;;
            2)
                case $1 in
                    "up")
                        ACTION="up"
                        VPN_NAME="$2"
                        ;;
                    *)
                        echo "Error: Command '$1' does not accept additional arguments"
                        usage
                        ;;
                esac
                ;;
            *)
                echo "Error: Too many arguments"
                usage
                ;;
        esac

        down() {
            CURRENT_CONNECTION="$(wg | grep interface | sed 's/.*: //')"

            if [ ! -z $CURRENT_CONNECTION ]; then
                wg-quick down $CURRENT_CONNECTION
                printf "\n\x1b[1;31mDisconnected from $CURRENT_CONNECTION\x1b[0m\n"
            else 
                echo "Not connected"
            fi
        }

        up() {
            down

            FOUND_CONFIGS=$(fd -tf "$VPN_NAME" -e "conf" --format '{/.}' /etc/wireguard)
            POSSIBLE_CONFIG_COUNTS=$(echo $FOUND_CONFIGS | wc -l)

            if [ $POSSIBLE_CONFIG_COUNTS -eq 0 ]; then
                echo "No configuration found for $VPN_NAME"
                exit 1
            fi

            if [ $POSSIBLE_CONFIG_COUNTS -gt 1 ]; then
                echo "Mulitple configurations found for $VPN_NAME:"
                echo $FOUND_CONFIGS
                exit 1
            fi

            printf "\n\x1b[1;32mConnecting to $FOUND_CONFIGS\x1b[0m\n\n"
            wg-quick up $FOUND_CONFIGS
        }


        # Example of how to use the variables
        case $ACTION in
            "status")
                wg
                ;;
            "list")
                echo "Possible connections:"
                fd . -tf -e "conf" --format '{/.}' /etc/wireguard
                ;;
            "down")
                down
                ;;
            "up")
                up
                ;;
        esac
      '')
    ];
  };
}
