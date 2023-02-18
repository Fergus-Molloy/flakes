{system, lib, home-manager, user, ... }:
{
  kirin = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user; };
    modules = [ 
      ./configuration.nix 
      ./kirin/hardward-configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [ ./home.nix ];
        };
      }
      ];
  }
}