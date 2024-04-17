{ ... }:
{
  imports = [
    ../../modules/kitty.nix
    ../../modules/neofetch.nix
    ../../modules/i3.nix
    ../../modules/tmux.nix
  ];
  home.file.".background-image".source = ../../modules/wall-1440;
  home.file.".xprofile".text = ''
    autorandr --load desktop
  '';
  programs.feh.enable = true;
}
