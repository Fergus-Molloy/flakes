{ config, ... }:
{
  programs.kitty.enable = true;
  home.file.".config/neofetch/config.conf".source = ./configs/neofetch.conf;
}
