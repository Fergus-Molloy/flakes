{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.share;
in
with lib;
{
  options.share = {
    enable = mkEnableOption "Enable file share client";
    mountPath = mkOption {
      type = types.path;
      default = "/home/fergus/share";
      description = "where to mount shared files";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # For mount.cifs, required unless domain name resolution is not needed.
      cifs-utils
      samba
    ];

    fileSystems."/mnt/share" = {
      device = "//share.molloy.xyz/storage";
      fsType = "cifs";
      options =
        let
          # this line prevents hanging on network split
          automount_opts = "x-systemd.automount,auto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

        in
        [
          "${automount_opts},credentials=/etc/nixos/smb-secrets"
          "uid=${toString config.users.users.fergus.uid},gid=${toString config.users.groups.samba.gid}"
          "iocharset=utf-8,noperm"
        ];
    };
  };
}
