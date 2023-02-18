{ lib, home-manager, user, ... }:
let
  system = "x86_64";
in {
  kirin = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user; };
    modules = [ 
      ./configuration.nix 
      ./kirin/hardware-configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [ ./home.nix ];
        };
      }
      ];
  };
}