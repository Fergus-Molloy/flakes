{ ... }:
{
  programs.kitty.enable = true;
  home.file.".config/fastfetch/config.jsonc".source = ./configs/fastfetch.jsonc;
}
