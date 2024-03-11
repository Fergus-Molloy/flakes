{
  colorschemes.kanagawa.enable = true;
  colorschemes.gruvbox.enable = false;
  colorschemes.rose-pine.enable = false;
  # not available yet
  # colorschemes.bamboo.enable = false;

  plugins = {
    which-key.enable = true;
    comment-nvim.enable = true;
    better-escape.enable = true;
    lastplace.enable = true;
    # quick-scope.enable = true;
    # vim-sneak.enable = true;

    fzf-lua = {
      enable = true;
      iconsEnabled = true;
      keymaps = {
        "<leader>b" = "buffers";
        "<leader>gf" = "git_files";
        "<leader>ff" = "files";
        "<leader>fg" = "live_grep";
        "<leader>fd" = "lsp_diagnostics";
        "<leader>fs" = "lsp_document_symbols";
        "gr" = "lsp_references";
      };
    };

    gitsigns = {
      enable = true;
      signs = {
        add.text = "+";
        change.text = "~";
        delete.text = "_";
        topdelete.text = "‾";
        changedelete.text = "~";
      };
    };
    indent-blankline = {
      enable = true;
      scope = {
        enabled = true;
        highlight = [ "@function" "@label" "@keyword" "@namespace" ];
      };
    };
    toggleterm = {
      enable = true;
      openMapping = "<leader>tt";
      shadeTerminals = false;
    };
    oil = {
      enable = true;
      skipConfirmForSimpleEdits = true;
    };
    mini = {
      enable = true;
      modules = {
        surround = { };
        pairs = { };
      };
    };

    luasnip = {
      enable = true;
      extraConfig = {
        enable_autosnippets = true;
      };
      fromLua = [
        {
          paths = ./snippets/heex.lua;
        }
        {
          paths = ./snippets/elixir.lua;
        }
      ];
    };

    lualine =
      {
        enable = true;
        iconsEnabled = true;
        theme = "auto";
        componentSeparators = { left = "|"; right = "|"; };
        sectionSeparators = { left = ""; right = ""; };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" "diff" "diagnostics" ];
          lualine_c = [ "filename" ];
          lualine_x = [ "encoding" "filetype" ];
          lualine_y = [{
            name = "datetime";
            extraConfig = { style = "Time %H:%M"; };
          }];
          lualine_z = [ "searchcount" ];
        };
        inactiveSections = {
          lualine_a = [ "mode" ];
          lualine_c = [ "filename" ];
        };
        # componentSeparators = "|";
        # sectionSeparators = "";
      };

    # deps
    fidget.enable = true;
    # nvim-web-devicons.enable = true;
    # neodiv.enable = true;
  } // import
    ./lsp
  // import
    ./treesitter;
}
