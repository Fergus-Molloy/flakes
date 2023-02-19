{ lib, home-manager, user, nixpkgs, ... }:
let
  system = "x86_64";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in {
  # desktop
  kirin = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user; };
    modules = [ 
      ./kirin
      ./configuration.nix 
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [ ./home.nix ./kirin/home.nix ];
        };
      }
      ];
  };
}