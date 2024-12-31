{ pkgs, user, ... }:
{
  imports = [
    ../../modules/kitty.nix
    ../../modules/neofetch.nix
    ../../modules/hyprland.nix
    ../../modules/tmux.nix
  ];
}
