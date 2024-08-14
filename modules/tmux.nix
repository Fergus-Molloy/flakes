{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    historyLimit = 100000;
    mouse = true;
    terminal = "tmux-256color";
    prefix = "C-Space";
    plugins = with pkgs; [ ];
    extraConfig = ''
      set -as terminal-features ",xterm-256color:RGB"

      set -g renumber-window on

      unbind l
      unbind k
      unbind j
      unbind h
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind c new-window -c "#{pane_current_path}"
    '';
    #set-option -ga terminal-overrides ",xterm-256color:Tc"
  };
}
