{
  config,
  pkgs,
  ...
}:
{
  users.users."fergus" = {
    uid = 1000;
    isNormalUser = true;
    description = "fergus";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "video"
      "audio"
      "samba"
    ];
    # Don't forget to the password with ‘passwd’.
    initialPassword = "password";
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };

  users.groups = {
    samba.gid = 1001;
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
