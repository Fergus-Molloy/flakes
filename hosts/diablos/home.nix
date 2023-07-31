{ pkgs, user, ... }:
{
  imports = [
    ../../modules/nvim.nix
    ../../modules/kitty.nix
    ../../modules/neofetch.nix
    ../../modules/tmux.nix
    ../../modules/i3.nix
  ];
  home.file.".background-image".source = ../../modules/wall-1440;
  programs.feh.enable = true;
}
