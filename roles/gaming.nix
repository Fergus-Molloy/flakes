{config, pkgs, lib, ...}:
let
cfg = config.roles.gaming;
in
with lib;
{
	options.roles.gaming = {
		enable = mkEnableOption "Gaming modules";
		steam = mkOption {
			type = types.bool;
			default = true;
		};
		minecraft = mkOption {
			type = types.bool;
			default = true;
		};
	};

	config = mkIf cfg.enable {
	  # enable steam
	  programs.steam = {
		enable = cfg.steam;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
	  };

	  # enable minecraft launcher
	  environment.systemPackages = optionals cfg.minecraft [pkgs.prismlauncher];
	};
}
