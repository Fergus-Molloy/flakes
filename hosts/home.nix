{ config, pkgs, user, ... }:

# Global home-manager configuration

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [ 
    firefox   # browser of choice
    vscode    # advanced editor
    kitty     # terminal of choice
    exa       # better ls
    flameshot # screenshot utility
    neofetch  # for fun :)
    ripgrep   # blazingly fast grep
    xclip     # command line copy-pasting
    bat       # prettier cat
    fd        # faster find
    bpytop    # better htop
   ];

   # extra programs that utilise bat
   programs.bat.extraPackages = with pkgs.bat-extras; [
    batman
    batdiff
   ];


   imports = [ 
    ../modules/zsh/zsh.nix
    ../modules/starship/starship.nix
    ];
}
