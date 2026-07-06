{ config, ... }:
{
  programs.kitty.enable = false;
  home.file.".config/kitty/kitty.conf".source = ./configs/kitty/kitty.conf;
  home.file.".config/kitty/gruvbox_dark.conf".source = ./configs/kitty/gruvbox_dark.conf;
  home.file.".config/kitty/kanagawa.conf".source = ./configs/kitty/kanagawa.conf;
  home.file.".config/kitty/melange.conf".source = ./configs/kitty/melange.conf;
  home.file.".config/kitty/rose-pine.conf".source = ./configs/kitty/rose-pine.conf;
}
