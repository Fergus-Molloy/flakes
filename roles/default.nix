{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./gaming.nix
    ./developer.nix
    ./vpn.nix
    ./monero.nix
  ];
}
