{ ... }:
{
  roles.streamer.enable = true;
  desktops.hyprland = {
    enable = true;
    enableLocking = true;
    extraConfig = ''
      $mon1 = DP-1
      $mon2 = HDMI-A-2
      monitor=DP-1,2560x1440@144,auto,auto
      monitor=$mon2,1920x1080@60,-1920x0,auto
    '';
  };
}
