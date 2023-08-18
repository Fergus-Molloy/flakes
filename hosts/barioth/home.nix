{ pkgs, user, ... }:
{
  imports = [
    ../../modules/kitty.nix
    ../../modules/neofetch.nix
    ../../modules/i3.nix
    ../../modules/tmux.nix
  ];
  home.file.".background-image".source = ../../modules/wall-1440;
  programs.feh.enable = true;
}
