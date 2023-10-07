{ pkgs, user, ... }:
{
  imports = [
    ../../modules/kitty.nix
    ../../modules/neofetch.nix
    ../../modules/i3.nix
    ../../modules/tmux.nix
  ];
  home.file.".background-image".source = ../../modules/wall-1440;
  home.file.".screen-setup" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      xrandr --auto --output HDMI-1 --mode 1920x1080 --same-as eDP-1
    '';
  };
  programs.feh.enable = true;
}
