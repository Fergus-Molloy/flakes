{ pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./kitty.nix
    ./firefox.nix
    ./neofetch.nix
    ./scripts.nix
    ./tmux.nix
    ./zsh.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "fergus";
  home.homeDirectory = "/home/fergus";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # firefox # browser of choice
    kitty # terminal of choice
    eza # better ls
    fastfetch # for fun :)
    ripgrep # blazingly fast grep
    xclip # command line copy-pasting
    bat # prettier cat
    fd # faster find
    btop # better htop
    waybar
  ];

  # extra programs that utilise bat
  programs.bat.extraPackages = with pkgs.bat-extras; [
    batman
    batdiff
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git";
    tmux.enableShellIntegration = true;
  };
}
