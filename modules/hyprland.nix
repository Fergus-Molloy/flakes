{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.desktops.hyprland;
in
with lib;
{
  options.desktops.hyprland = {
    enable = mkEnableOption "Enable hyprland desktop environment";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    # let hyprlock perform authentication
    security.pam.services.hyprlock = { };

    environment.systemPackages = with pkgs; [
      hyprpolkitagent
      hyprshot
      wl-clipboard
      libnotify # notify-send
    ];

    services = {
      xserver.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = false;
    };
  };
}
