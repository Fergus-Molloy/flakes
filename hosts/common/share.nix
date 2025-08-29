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
      davfs2
    ];

    services.davfs2 = {
      enable = true;
    };
    systemd.mounts = [
      {
        description = "webdav mount for copyparty";
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        what = "https://share.molloy.xyz";
        where = cfg.mountPath;
        options = "x-systemd.automount,user,uid=fergus,noatime,rw,_netdev";
        type = "davfs";
      }
    ];
    environment.etc = {
      "davfs2/secret" = {
        mode = "0600";
        text = ''
          https://share.molloy.xyz "" ""
        '';
      };
    };
    fileSystems."/home/fergus/share" = {
      device = "https://share.molloy.xyz";
      fsType = "davfs";
      options = [
        "noatime"
        "rw"
        "noauto"
        "user"
        "uid=fergus"
        "x-systemd.automount"
        "x-systemd.mount-timeout=30"
        "_netdev"
      ];
    };
  };
}
