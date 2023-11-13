{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    terminal = "tmux-256color";
    plugins = with pkgs; [ ];
    extraConfig = ''
      set -g mouse on
    '';
    #set-option -ga terminal-overrides ",xterm-256color:Tc"
  };
}
