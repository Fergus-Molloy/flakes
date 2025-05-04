{ ... }:
{
  desktops.hyprland = {
    enable = true;
    extraConfig = ''
      monitor=,1920x1080,auto,1,bitdepth,8
      monitor=,preferred,auto,1,mirror,eDP-1,bitdepth,8
      xwayland {
      	force_zero_scaling = true
      }
    '';
  };
}
