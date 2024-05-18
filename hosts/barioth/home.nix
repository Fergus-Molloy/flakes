{ ... }:
{
  imports = [
    ../../modules/kitty.nix
    ../../modules/neofetch.nix
    ../../modules/i3.nix
    ../../modules/tmux.nix
  ];
  home.file.".xprofile".text = ''
    autorandr --load multi
  '';
}
