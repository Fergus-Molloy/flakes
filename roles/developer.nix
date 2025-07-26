{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.roles.developer;
in
with lib;
{
  imports = [ ../modules/nvim.nix ];
  options.roles.developer = {
    enable = mkEnableOption "Development/coding modules";
    lsps = mkOption {
      type = with types; listOf package;
      default = [ ];
      description = "lsps and formatters to install";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    # enable keybase daemon for gpg keys
    services.kbfs.enable = true;
    environment.systemPackages = with pkgs; [
      keybase # gpg identity verifier
      gnupg
      gh
      docker-buildx
    ];

    packages.nvim-custom = {
      enable = true;
      lsps =
        with pkgs;
        [
          stylua
          nixfmt-rfc-style
        ]
        ++ cfg.lsps;
    };

    programs.git = {
      enable = true;
      config = {
        user = {
          name = "Fergus Molloy";
          email = "fergus@molloy.xyz";
        };
        checkout = {
          defaultRemote = "origin";
          guess = true;
        };
        init = {
          defaultBranch = "main";
        };
        branch = {
          autoSetupRebase = "always";
        };
        push = {
          autoSetupRemote = true;
        };
        # create this manually on each machine, to store gpg stuff
        include = {
          path = "/home/fergus/.gituser";
        };
      };
    };

  };
}
