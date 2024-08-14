{ pkgs, ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      keybinding.universal = {
        quit = "<c-c>";
        quit-alt1 = "<c-c>";
      };
      git = {
        autoFetch = false;
        autoRefresh = false;
      };
      gui.nerdFontsVersion = "3";
      disableStartupPopups = true;
    };
  };
}
