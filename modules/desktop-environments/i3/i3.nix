{config, ...}:
{
  services.xserver = {
    enable = true;
    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+i3";
    };
    windowManager = {
      i3.enable = true;
    };
  };

  # services.picom = {
  #   enable = true;
  #   vSync = true;
  #   fade = true;
  #   backend = "glx";
  #   settings = {
  #     glx-swap-method = 2;
  #   };
  #   # make some stuff sligtly transparent
  #   # opacityRules = ["90:class_g = 'kitty'"];
  # };
}