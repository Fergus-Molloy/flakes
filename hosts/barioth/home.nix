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
      monitor=DP-1,2560x1440@144,auto,auto
      monitor=HDMI-A-1,1920x1080@60,-1920x0,auto
    '';
  };
}
