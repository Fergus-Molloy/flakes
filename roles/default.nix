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
    ./llm.nix
    ./monero.nix
    ./streamer.nix
    ./vpn.nix
  ];
}
