{ pkgs, ... }:
{
  home.file.".config/hypr/hyprland.conf" = {
    source = ./configs/hyprland.conf;
    # hyprland automatically creates this file, we want to overwrite it
    force = true;
  };
  home.file.".config/hypr/hyprlock.conf" = {
    source = ./configs/hyprlock.conf;
  };
  # lock screens
  home.file.".config/hypr/wall0.png" = {
    source = ./assets/wall0.png;
  };
  home.file.".config/hypr/wall1.png" = {
    source = ./assets/wall1.png;
  };
  home.file.".config/hypr/wall2.png" = {
    source = ./assets/wall2.png;
  };
  # script to rotate lockscreens, images should have the name wall<n>.png
  # where n is an incrementing number starting from 0
  home.file.".config/hypr/rotate-lockscreen.sh" = {
    executable = true;
    text = #bash
      ''
        #!/usr/bin/env bash
        DIR="/home/fergus/.config/hypr"

        for file in $(ls $DIR/*.png | sort -r); do
          num=$(echo $file | sed 's/.*\([0-9]\)\+.png/\1/') # wall0.png -> 0
          new_num=$(echo $num | awk '{$1=$1+1;print}') # 0 -> 1
      
          if [[ -z $FIRST ]]; then
            FIRST=$DIR/wall$${new_num}.png
          fi

          mv $file $DIR/wall$${new_num}.png
        done

        mv $FIRST $DIR/wall0.png
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
      enable = true;
      settings = {
        general = {
          ignore_dbus_inhibit = false;
          # don't lock if already locked
          lock_cmd = "pidof hyprlock || hyprlock";
        };

        listener = [
          {
            timeout = 300;
            on-timeout = ''
              loginctl lock-session
            '';
          }
          {
            timeout = 420;
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
    };
    # status bar
    waybar = {
      enable = true;
    };
    # desktop locker
    hyprlock = {
      enable = true;
    };
  };
}

