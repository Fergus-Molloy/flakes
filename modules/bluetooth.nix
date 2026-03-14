{
  config,
  lib,
  pkgs,
  lanzaboote,
  ...
}:
let
  cfg = config.bluetooth;
in
with lib;
{
  options.bluetooth = {
    enable = mkEnableOption "Enable blue tooth";
    devices = mkOption {
      type = types.listOf types.str;
      default = [ ];
      example = [ "F8:D3:F0:62:94:00" ];
      description = "list of devices to automatically connect to";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bluez
    ];
    systemd = mkIf ((length cfg.devices) > 0) {
      services.bt-autoconnect = {
        serviceConfig = {
          Type = "oneshot";
          User = "fergus";
          Group = "fergus";
        };
        path = [
          pkgs.bash
          pkgs.bluez
        ];
        script = strings.concatLines (map (dev: "bluetoothctl connect '${dev}' || true") cfg.devices) + ''
          exit 0
        '';
      };
      timers.bt-autoconnect = {
        wantedBy = [ "timers.target" ];
        partOf = [ "bt-autoconnect.service" ];
        timerConfig = {
          OnBootSec = "1m"; # wait 1 min before trying to run
          OnActiveSec = "${toString ((length cfg.devices) * 6)}s"; # run every 6 seconds per device
          Unit = "bt-autoconnect.service";
        };
      };
    };
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
  };
}
