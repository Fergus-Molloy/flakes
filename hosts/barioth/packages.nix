{ pkgs, user, inputs, ... }:
let
  nixCats = import ../../modules/nixcats { inherit inputs; };
in
{
  imports = [
    nixCats.nixosModules.default
  ];

  nixCats = {
    enable = true;
    packageNames = [ "nixCats" ];
  };
  environment.variables = {
    EDITOR = "nixCats";
  };

  # Extra packages just for this system
  environment.systemPackages = with pkgs;
    [
      udisks # for mounting usb devices
      mullvad-vpn
      tmuxinator
      autorandr

      handbrake
      vlc

      (pkgs.kodi.withPackages (kodiPkgs: with kodiPkgs; [
        jellyfin
      ]))

      obsidian
      keepassxc

      monero-gui
      p2pool

      grub2

      pavucontrol
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
