{config, ...}:
{
  services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true; # sddm doesn't seem to work on all machines
    };
    desktopManager = {
      plasma5.enable = true;
    };
  };
}