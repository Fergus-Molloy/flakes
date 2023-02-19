{config, lib, pkgs, ... }:
{
  services = {
    polybar = {
      enable = true;
      package = pkgs.polybar.override {
        i3GapsSupport = true;
        alsaSupport = true;
      };
      script = ''polybar top &'';
      config = {
        "colors" = {
          fg-dark       = "#a89984";
          fg            = "#ebdbb2";
          fg-light      = "#fbf1c7";
          bg-dark       = "#1d2021";
          bg            = "#282828";
          bg-light      = "#3c3836";
          red           = "#cc241d";
          red-bright    = "#fb4934";
          green         = "#98971a";
          green-bright  = "#b8bb26";
          yellow        = "#d79921";
          yellow-bright = "#fabd2f";
          blue          = "#458588";
          blue-bright   = "#83a598";
          purple        = "#b16286";
          purple-bright = "#d3869b";
          aqua          = "#689d6a";
          aqua-bright   = "#8ec07c";
          orange        = "#d65d0e";
          orange-bright = "#fe8019";
        };
        "bar/top" = {
          bottom = false;
          offset-x = 5;
          offset-y = 5;
          radius = 2;
          background = "\${colors.bg}";
          foreground = "\${colors.fg}";
          padding = 2;
          font-0 = "NotoSans-Regular:size=14;2";
          separator = " ";
          modules-left = "i3";
          modules-center = "date";
          modules-right = "cpu memory battery time";
        };
        "module/i3" = {
          type = "internal/i3";
          show-urgent = true;
          index-sort = true;

          label-mode-padding = 1;
          label-mode-foreground = "\${colors.fg}";

          # focused = Active workspace on focused monitor
          label-focused = "%name%";
          label-focused-underline = "\${colors.red}";
          label-focused-padding = 2;
          label-focused-foreground = "\${colors.fg}";

          # unfocused = Inactive workspace on any monitor
          label-unfocused = "%name%";
          label-unfocused-padding = 1;;
          label-unfocused-foreground = "\${colors.fg-dark}";
          
          # visible = Active workspace on unfocused monitor
          label-visible = "%name%";
          label-visible-background = "\${self.label-focused-bg}";
          label-visible-underline = "\${self.label-focused-underline}";
          label-visible-padding = "\${self.label-focused-padding}";
          
          # urgent = Workspace with urgency hint set
          label-urgent = "%name%";
          label-urgent-background = "\${colors.red-bright}";
          label-urgent-padding = 1;
        };
        "module/date" = {
          type = "internal/date";
          interval = 60;
          date = "%a, %d %b %Y";
          label = "%date%";
        };
        "module/time" = {
          type = "internal/date";
          interval = 1;
          time = "%H:%M";
          label = "%time%";
          format-underline = "\${colors.purple}";
        };
        "module/cpu" = {
          type = "internal/cpu";
          warn-percentage = 90;
          label = "%percentage%%";
          format-prefix = "util: ";
          format-underline = "\${colors.green}";
        };
        "module/memory" = {
          type = "internal/memory";
          label = "%used% / %total%";
          format-prefix = "mem: ";
          format-underline = "\${colors.yellow}";
        };
      };
    };
  };
}
