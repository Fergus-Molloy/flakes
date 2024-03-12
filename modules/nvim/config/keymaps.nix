{
  keymaps = [
    # better defaults
    {
      mode = [ "n" "v" ];
      key = "<space>";
      action = "<nop>";
      options.silent = true;
    }
    {
      mode = "n";
      key = ";";
      action = ":";
      options = {
        silent = true;
        nowait = true;
      };
    }
    {
      mode = "n";
      key = "n";
      action = "nzz";
      options = {
        silent = true;
        desc = "Center search results";
      };
    }
    {
      mode = "n";
      key = "N";
      action = "Nzz";
      options = {
        silent = true;
        desc = "Center search results";
      };
    }
    {
      mode = "n";
      key = "<C-h>";
      action = "<cmd>nohl<cr>";
      options = {
        silent = true;
        desc = "Remove search highlight";
      };
    }
    {
      mode = "n";
      key = "<leader>fm";
      action = "<cmd>Format<cr>";
      options = {
        silent = true;
        desc = "Format the current document";
      };
    }
    # handle word wrap better
    {
      mode = "n";
      key = "k";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        silent = true;
        expr = true;
      };
    }
    {
      mode = "n";
      key = "j";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        silent = true;
        expr = true;
      };
    }
    # navigate buffers
    {
      mode = "n";
      key = "<c-n>";
      action = "<cmd>bn<cr>";
      options = {
        silent = true;
        desc = "Next buffer";
      };
    }
    {
      mode = "n";
      key = "<c-p>";
      action = "<cmd>bp<cr>";
      options = {
        silent = true;
        desc = "Previous buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>x";
      action = "<cmd>bd<cr>";
      options = {
        silent = true;
        desc = "Delete buffer";
      };
    }
    # don't replace register when pasting
    {
      mode = "x";
      key = "p";
      action = "pgvy";
      options = {
        silent = true;
      };
    }
    {
      mode = "x";
      key = "P";
      action = "Pgvy";
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>fo";
      action = "<cmd>Oil --float<cr>";
      options = {
        silent = true;
      };
    }
  ] ++ import ./toggleterm.nix;
}
