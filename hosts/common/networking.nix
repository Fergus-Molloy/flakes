{
  config,
  lib,
  ...
}:
{
  # Open ports in the firewall.
  networking = {
    firewall.enable = lib.mkDefault true;
    networkmanager.enable = lib.mkDefault true;
    # resolvconf.extraConfig = ''
    #   nameserver 8.8.8.8
    # '';
  };
}
