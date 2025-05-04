{ config, pkgs, ... }:
{
  # Configure console keymap
  console.keyMap = "uk";
  # setup mouse and keyboard for xserver
  services.xserver = {
    xkb = {
      layout = "gb";
      variant = "";
    };
  };
  services.libinput = {
    enable = true;
    mouse.accelProfile = "flat";
    mouse.accelSpeed = "1";
  };
}
