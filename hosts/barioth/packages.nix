{ pkgs, user, inputs, ... }:
{
imports = [
../../modules/nvim.nix
];
  packages.nvim-custom = {
  enable = true;
  lsps = with pkgs; [
    stylua
    nixpkgs-fmt
  ];
  };

  # Extra packages just for this system
  environment.systemPackages = with pkgs;
    [
      udisks # for mounting usb devices
      mullvad-vpn
      tmuxinator

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

  users.users.${user}.packages = with pkgs; [
    discord # chat app
  ];

  nixpkgs.overlays = [
    # This overlay will pull the latest version of Discord
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: {
          src = builtins.fetchTarball {
            url = "https://discord.com/api/download?platform=linux&format=tar.gz";
            sha256 = "1ivcw1cdxgms7dnqy46zhvg6ajykrjg2nkg91pibv60s5zqjqnj2";
          };
        }
      );
    })
  ];
}
