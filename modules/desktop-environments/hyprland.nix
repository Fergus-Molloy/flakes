{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = false;
  };
}
