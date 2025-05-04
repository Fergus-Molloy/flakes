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
    # enable mullvad daemon
    services.mullvad-vpn.enable = true;
    environment.systemPackages = with pkgs; [
      mullvad-vpn
    ];
  };
}
