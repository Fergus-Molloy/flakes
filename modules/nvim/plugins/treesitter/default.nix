{
  treesitter = {
    enable = true;
    nixGrammars = true;
    ensureInstalled = "all";
    indent = true;
    incrementalSelection.enable = false;
  };
  treesitter-textobjects = {
    enable = true;
    select = {
      enable = true;
      lookahead = true;
      keymaps = {
        "aa" = "@parameter.outer";
        "ia" = "@parameter.inner";
        "af" = "@function.outer";
        "if" = "@function.inner";
      };
    };
  };
  ts-autotag = {
    enable = true;
    filetypes = [ "html" "heex" ];
  };
}
