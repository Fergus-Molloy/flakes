{
  description = "All my dev shells";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
      in
      with pkgs; {
        devShells = {
          nix = mkShellNoCC { buildInputs = [ nil nixpkgs-fmt ]; };
          lua = mkShellNoCC { buildInputs = [ lua-language-server stylua ]; };
          rust = mkShell {
            buildInputs = [
              openssl
              pkg-config
              rust-bin.stable.latest.default
              rust-analyzer
            ];
          };
          rustNode = mkShell {
            buildInputs = [
              openssl
              pkg-config
              nodejs_20
              rust-bin.stable.latest.default
              rust-analyzer
            ];
          };
        };
      });
}
