{ ... }:
{
  services.xserver = {
    enable = true;
    displayManager = {
      lightdm.enable = true;
      defaultSession = "xfce+i3";
    };
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
    windowManager = {
      i3.enable = true;
    };
  };
}
