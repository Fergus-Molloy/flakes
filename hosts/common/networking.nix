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
  };
}
