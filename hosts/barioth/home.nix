{ ... }:
{
  imports = [
    ../../modules/kitty.nix
    ../../modules/neofetch.nix
    ../../modules/hyprland.nix
    ../../modules/tmux.nix
  ];
  home.file.".xprofile".text = ''
    autorandr --load multi
  '';

  desktops.hyprland = {
    enable = true;
    enableLocking = true;
    extraConfig = ''
      monitor=,highrr,auto,auto
    '';
  };
}
