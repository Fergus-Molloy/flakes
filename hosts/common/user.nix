{
  config,
  pkgs,
  ...
}:
{
  users.users."fergus" = {
    isNormalUser = true;
    description = "fergus";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "video"
      "audio"
    ];
    # Don't forget to the password with ‘passwd’.
    initialPassword = "password";
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };

  # user shell
  programs.zsh.enable = true;

  environment.variables = {
    TERM = "kitty";
    TERMINAL = "kitty";
  };

  # need both shells otherwise weird things can happen with user accounts
  environment.shells = with pkgs; [
    bashInteractive
    zsh
  ];
}
