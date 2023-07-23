{
  description = "A devShell example";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      with pkgs;
      {
        devShells = {
          rustNode = mkShell {
            buildInputs = [
              openssl
              pkg-config
              exa
              fd
              ripgrep
              nodejs_20
              rust-bin.stable.latest.default
              rust-analyzer
            ];

            shellHook = ''
              alias ls='exa -lh -s=name --git --group-directories-first --no-permissions --no-user --icons'
              alias find=fd
              alias grep=rg
              alias v=nvim
            '';
          };
        };
      }
    );
}

