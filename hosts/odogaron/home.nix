{ pkgs, user, ... }:
{
  imports = [
    ../../modules/kitty.nix
    ../../modules/neofetch.nix
    ../../modules/i3.nix
    ../../modules/tmux.nix
  ];
  home.file.".screen-setup" = {
    enable = true;
    executable = true;
    text = ''
      #!/usr/bin/env bash
      xrandr --auto --output HDMI-1 --mode 1920x1080 --same-as eDP-1
    '';
  };
}
