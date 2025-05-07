{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./developer.nix
    ./gaming.nix
    ./monero.nix
    ./streamer.nix
    ./vpn.nix
  ];
}
