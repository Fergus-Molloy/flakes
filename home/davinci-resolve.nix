{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.roles.streamer;
in
with lib;
{
  options.roles.streamer = {
    enable = mkEnableOption "Enable streaming software";
  };
  config = mkIf cfg.enable {
    xdg.desktopEntries = {
      davinci-resolve = {
        name = "Davinci Resolve";
        exec = "davinci-amd";
        terminal = false;
        categories = [ "Application" ];
      };
    };
  };
}
