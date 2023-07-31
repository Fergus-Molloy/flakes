{ pkgs, user, ... }:
{
  imports = [
    ../../modules/kitty.nix
    ../../modules/neofetch.nix
  ];
}
