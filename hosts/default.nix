{ lib, home-manager, user, nixpkgs,myVim, ... }:
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
    specialArgs = { inherit user myVim; };
    modules = [
      ./barioth
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [ ./home.nix ./barioth/home.nix ];
        };
      }
    ];
  };
  # laptop
  diablos = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user; };
    modules = [
      ./diablos
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [ ./home.nix ./diablos/home.nix ];
        };
      }
    ];
  };
  # vm
  kirin = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user; };
    modules = [
      ./kirin
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [ ./home.nix ./kirin/home.nix ];
        };
      }
    ];
  };
  # work
  odogaron = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user; };
    modules = [
      ./odogaron
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [ ./home.nix ./odogaron/home.nix ];
        };
      }
    ];
  };
}
