{
  lib,
  home-manager,
  user,
  nixpkgs,
  inputs,
  ...
}:
let
  system = "x86_64";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  # Desktop
  barioth = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit user inputs;
      host = "barioth";
    };
    modules = [
      ./barioth
      ./configuration
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [
            ./home.nix
            ./barioth/home.nix
          ];
        };
      }
    ];
  };
  # laptop
  diablos = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user inputs; };
    modules = [
      ./diablos
      ./configuration
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [
            ./home.nix
            ./diablos/home.nix
          ];
        };
      }
    ];
  };
}
