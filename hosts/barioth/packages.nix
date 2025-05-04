{ pkgs, user, inputs, ... }:
{
imports = [
../../modules/nvim.nix
];
  packages.nvim-custom = {
  enable = true;
  lsps = with pkgs; [
    stylua
    nixfmt
  ];
  };

  # Extra packages just for this system
  environment.systemPackages = with pkgs;
    [
      udisks # for mounting usb devices
      mullvad-vpn

      monero-gui
      p2pool
      librespot

      pavucontrol

      wireguard-tools

      (wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      })
    ];
  virtualisation.docker.enable = true;

  # user shell
  programs.zsh.enable = true;

}
