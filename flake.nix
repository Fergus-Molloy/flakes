{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager }:
    let 
      system = "x86_64-linux";
      user = "fergus";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
  kirin = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user; };
    modules = [ 
      ./hosts/configuration.nix 
      ./hosts/kirin/hardward-configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [ ./hosts/home.nix ];
        };
      }
      ];
  };
      };
    };
}
