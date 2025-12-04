{
  lib,
  home-manager,
  nixpkgs,
  lanzaboote,
  determinate,
  nur,
  ...
}:
let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  # Desktop
  barioth = lib.nixosSystem {
    modules = [
      determinate.nixosModules.default
      lanzaboote.nixosModules.lanzaboote
      nur.modules.nixos.default
      { nixpkgs.hostPlatform = system; }
      { networking.hostName = "barioth"; }
      ./barioth
      ./common
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users."fergus" = {
          imports = [
            ../home
            ./barioth/home.nix
          ];
        };
      }
    ];
  };
  # laptop
  diablos = lib.nixosSystem {
    modules = [
      { nixpkgs.hostPlatform = system; }
      { networking.hostName = "diablos"; }
      ./diablos
      ./common
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users."fergus" = {
          imports = [
            ../home
            ./diablos/home.nix
          ];
        };
      }
    ];
  };
}
