{ ... }:
{
  desktops.hyprland = {
    enable = true;
    enableLocking = true;
    extraConfig = ''
      local mon1 = "DP-2"
      local mon2 = "HDMI-A-1"
      hl.monitor({
        output = "$mon1",
        mode = "2560x1440@144",
        position = "auto",
        scale = "auto",
      })
      hl.monitor({
        output = "$mon2",
        mode = "1920x1080@60",
        position = "-1920x0",
        scale = "auto",
      })
    '';
  };
}
