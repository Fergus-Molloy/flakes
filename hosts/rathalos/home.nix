{ ... }:
{
  imports = [
    ../../modules/kitty.nix
    ../../modules/neofetch.nix
    ../../modules/tmux.nix
    ../../modules/nvim.nix
  ];

  packages.nvim-custom.enable = true;
}
