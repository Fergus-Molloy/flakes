{ ... }:
{
  desktops.hyprland = {
    enable = true;
    enableLocking = true;
    extraConfig = ''
      hl.monitor({
        output = "desc:Acer Technologies XB271HU #ASPKrvWZC2vd",
        mode = "2560x1440@144",
        position = "auto",
        scale = "auto",
      })
      hl.monitor({
        output = "desc:Dell Inc. DELL SE2422HX FS5KWB3",
        mode = "1920x1080@60",
        position = "-1920x0",
        scale = "auto",
      })
    '';
  };
}
