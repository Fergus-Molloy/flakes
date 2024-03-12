{
  enable = true;
  formattersByFt = {
    rust = [ "rustfmt" ];
    lua = [ "stylua" ];
    nix = [ "nixpkgs_fmt" ];
  };
  formatOnSave = {
    lspFallback = true;
  };
}
