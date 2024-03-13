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
]
