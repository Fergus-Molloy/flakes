{
  description = "All my dev shells";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      rust-overlay,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
        ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_12;
      in
      with pkgs;
      {
        devShells = {
          c = mkShell {
            buildInputs = [
              autoconf
              automake
            ];
          };
          nix = mkShellNoCC {
            buildInputs = [
              nil
              nixpkgs-fmt
            ];
          };
          lua = mkShellNoCC {
            buildInputs = [
              lua-language-server
              stylua
            ];
          };
          astro = mkShellNoCC {
            buildInputs = [
              nodejs_18
              nodePackages."vscode-langservers-extracted"
              nodePackages."@astrojs/language-server"
              nodePackages."typescript-language-server"
              nodePackages."typescript"
            ];
          };
          node = mkShellNoCC {
            buildInputs = [
              nodejs_18
              nodePackages."vscode-langservers-extracted"
            ];
          };
          solid = mkShellNoCC {
            buildInputs = [
              nodejs_18
              nodePackages."prettier"
              nodePackages."vscode-langservers-extracted"
              nodePackages."typescript-language-server"
              nodePackages."typescript"
            ];
          };
          elixir = mkShell {
            buildInputs = [
              beam.packages.erlang_27.elixir
              elixir-ls
              libnotify
              inotify-tools
              watchexec
              beam.packages.erlang_27.erlang
            ];
          };
          erlang = mkShellNoCC {
            buildInputs = [
              beam.packages.erlang_27.erlang
              erlang-ls
              rebar3
            ];
          };
          go = mkShell {
            buildInputs = [
              go
              gopls
              goimports-reviser
            ];
          };
          ocaml = mkShell {
            nativeBuildInputs = with ocamlPackages; [
              ocaml
              findlib
              dune_3
              ocaml-lsp
              utop
              ocamlformat
              odoc
            ];
            buildInputs = with ocamlPackages; [
              ocamlgraph
              ocamlPackages.core
              ocamlPackages.core_unix
            ];
          };
          dotnet = mkShell {
            buildInputs = [
              csharp-ls
              dotnetCorePackages.sdk_7_0
              nodejs_20
              vscode-extensions.ms-dotnettools.csharp
            ];
          };
          treesitter = mkShell {
            buildInputs = [
              gcc
              nodejs
              neovim
              tree-sitter
              (python39.withPackages (
                pp: with pp; [
                  pynvim
                ]
              ))
            ];
          };
          cpp = mkShell {
            buildInputs = [
              nil
              nixpkgs-fmt
              cmake
              gnumake
              hwloc
              openssl
              libuv
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
      }
    );
}
