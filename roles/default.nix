{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./ai.nix
    ./developer.nix
    ./gaming.nix
    ./monero.nix
    ./streamer.nix
    ./vpn.nix
  ];
}
