{ ... }:
{
  imports = [ ./polybar.nix ];
  home.file.".config/i3/config".source = ./configs/i3-config;
  programs.rofi.enable = true;
}
