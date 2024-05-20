{ config, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager = {
      i3.enable = true;
    };
  };

  services.displayManager = {
    defaultSession = "none+i3";
  };

  services.picom = {
    enable = true;
    vSync = true;
    fade = true;
    fadeDelta = 1;
    backend = "glx";
    settings = {
      glx-swap-method = 2;
    };
    # make some stuff sligtly transparent
    # opacityRules = ["90:class_g = 'kitty'"];
  };
}
