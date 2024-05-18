{ pkgs, user, ... }:
{
  imports = [
    ../../modules/kitty.nix
    ../../modules/neofetch.nix
    ../../modules/tmux.nix
    ../../modules/i3.nix
  ];
}
