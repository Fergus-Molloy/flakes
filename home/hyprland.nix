{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.desktops.hyprland;
in
{
  options.desktops.hyprland = {
    enable = mkEnableOption (lib.mdDoc "hyprland window manager");

    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = mdDoc ''
        Extra configuration to add to the end of normal configuration file
      '';
    };

    enableLocking = mkOption {
      type = types.bool;
      default = false;
      description = mdDoc ''
        Enable hyprlock and start it automatically
      '';
    };
  };

  config = mkIf cfg.enable {
    home.file.".config/hypr/hyprland.conf" = {
      text = (builtins.readFile ./configs/hyprland.conf) + cfg.extraConfig;
      # hyprland automatically creates this file, we want to overwrite it
      force = true;
    };
    home.file.".config/hypr/hyprlock.conf" = mkIf cfg.enableLocking {
      source = ./configs/hyprlock.conf;
    };
    # lock screens
    home.file.".config/hypr/wall0.png" = mkIf cfg.enableLocking {
      source = ./assets/wall0.png;
    };
    home.file.".config/hypr/wall1.png" = mkIf cfg.enableLocking {
      source = ./assets/wall1.png;
    };
    home.file.".config/hypr/wall2.png" = mkIf cfg.enableLocking {
      source = ./assets/wall2.png;
    };
    # script to rotate lockscreens, images should have the name wall<n>.png
    # where n is an incrementing number starting from 0
    home.file.".config/hypr/rotate-lockscreen.sh" = mkIf cfg.enableLocking {
      executable = true;
      text = # bash
        ''
          #!/usr/bin/env bash
          DIR="/home/fergus/.config/hypr"

          for file in ''$(ls ''$DIR/*.png | sort -r); do
            num=''$(echo ''$file | sed 's/.*\([0-9]\)\+.png/\1/') # wall0.png -> 0
            new_num=''$(echo ''$num | awk '{''$1=''$1+1;print}') # 0 -> 1

            if [[ -z ''$FIRST ]]; then
              FIRST="''$DIR/wall''${new_num}.png"
            fi

            mv ''$file "''$DIR/wall''${new_num}.png"
          done

          mv ''$FIRST ''$DIR/wall0.png
        '';
    };

    home.file.".config/waybar".source = ./configs/waybar;

    services = {
      # notifications
      swaync = {
        enable = true;
      };

      # clipboard
      cliphist = {
        enable = true;
        allowImages = true;
      };

      # lock after timeout
      hypridle = {
        enable = cfg.enableLocking; # not working currently
        settings = {
          general = {
            ignore_dbus_inhibit = false;
            # don't lock if already locked
            lock_cmd = "pidof hyprlock || hyprlock";
          };

          listener = [
            {
              timeout = 900;
              on-timeout = ''
                loginctl lock-session
              '';
            }
            {
              timeout = 1200;
              on-timeout = ''
                hyprctl dispatch dpms off
              '';
              on-resume = ''
                hyprctl dispatch dpms on
              '';
            }
          ];
        };
      };
    };

    programs = {
      # launcher
      wofi = {
        enable = true;
        style = ''
          window {
          margin: 0px;
          border: 1px solid #7E9CD8;
          background-color: #16161D;
          }

          #input {
          margin: 5px;
          border: 1px solid #7E9CD8;
          color: #C8C093;
          background-color: #1F1F28;
          }

          #inner-box {
          margin: 5px;
          border: none;
          background-color: #16161D;
          }

          #outer-box {
          margin: 5px;
          border: none;
          background-color: #16161D;
          }

          #scroll {
          margin: 0px;
          border: none;
          }

          #text {
          margin: 5px;
          border: none;
          color: #C8C093;
          } 

          #entry.activatable #text {
          color: #16161D;
          }

          #entry > * {
          color: #C8C093;
          }

          #entry:selected {
          background-color: #1F1F28;
          }

          #entry:selected #text {
          font-weight: bold;
          }
        '';
      };
      # status bar
      waybar = {
        enable = true;
      };
      # desktop locker
      hyprlock = {
        enable = cfg.enableLocking;
      };
    };
  };
}
