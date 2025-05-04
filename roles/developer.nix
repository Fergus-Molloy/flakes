{config, pkgs, lib, ...}:
let
cfg = config.roles.developer;
in
with lib;
{
	options.roles.developer = {
		enable = mkEnableOption "Development/coding modules";
	};

	config = mkIf cfg.enable {
		imports = [ ../modules/nvim.nix ];

		packages.nvim-custom.enable = true;
	};
}
