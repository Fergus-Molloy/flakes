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
        ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_12;
      in
      with pkgs; {
        devShells = {
          nix = mkShellNoCC { buildInputs = [ nil nixpkgs-fmt ]; };
          lua = mkShellNoCC { buildInputs = [ lua-language-server stylua ]; };
          astro = mkShellNoCC { buildInputs = [ nodejs_20 nodePackages."vscode-langservers-extracted" nodePackages."@astrojs/language-server" nodePackages."typescript-language-server" nodePackages."typescript" ]; };
          node = mkShellNoCC { buildInputs = [ nodejs_20 nodePackages."vscode-langservers-extracted" ]; };
          elixir = mkShellNoCC { buildInputs = [ elixir libnotify inotify-tools ]; };
          ocaml = mkShell {
            nativeBuildInputs = with ocamlPackages; [ ocaml findlib dune_3 ocaml-lsp utop ocamlformat odoc ];
            buildInputs = with ocamlPackages; [ ocamlgraph ocamlPackages.core ocamlPackages.core_unix ];
          };
          dotnet = mkShell { buildInputs = [ omnisharp-roslyn dotnetCorePackages.sdk_7_0 nodejs_20 ]; };
          treesitter = mkShell {
            buildInputs = [
              gcc
              nodejs
              neovim
              tree-sitter
              (python39.withPackages (pp: with pp; [
                pynvim
              ]))
            ];
          };
          rust = mkShell {
            buildInputs = [
              openssl
              pkg-config
              rust-bin.stable.latest.default
              rust-analyzer
              cargo-criterion
              cargo-nextest
              gnuplot
              clang
              llvmPackages.bintools
            ];
          };
          rustNightly = mkShell {
            buildInputs = [
              openssl
              pkg-config
              rust-bin.nightly.latest.default
              rust-analyzer
              cargo-criterion
              cargo-nextest
              gnuplot
              clang
              llvmPackages.bintools
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
