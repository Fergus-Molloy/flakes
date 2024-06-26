[
  # toggle term
  {
    mode = [ "n" "t" ];
    key = "<leader>tt";
    action = "<cmd>ToggleTerm<cr>";
    options.silent = true;
  }
  # oil
  {
    mode = "n";
    key = "<leader>fo";
    action = "<cmd>Oil --float<cr>";
    options = {
      silent = true;
    };
  }
  # sneak
  {
    mode = "n";
    key = "s";
    action = "<Plug>Sneak_s";
    options = {
      silent = true;
    };
  }
  {
    mode = "n";
    key = "S";
    action = "<Plug>Sneak_S";
    options = {
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>e";
    action = "<cmd>lua vim.diagnostic.open_float()<cr>";
    options = {
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>gg";
    action = "<cmd>LazyGit<cr>";
    options = {
      silent = true;
    };
  }
]
