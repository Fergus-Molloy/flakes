{ pkgs, ... }: {
  colorschemes = {
    kanagawa.enable = true;
    rose-pine.enable = false;

    base16 = {
      enable = false;
      colorscheme = "gruvbox-material-dark-soft";
      setUpBar = false;
    };

    # bamboo = {
    #   enable = false;
    #   settings = {
    #     colors = {
    #       green = "#00ffaa";
    #     };
    #     highlights = {
    #       TSString = { fg = "$blue"; };
    #     };
    #   };
    # };
  };

  extraPlugins = with pkgs.vimPlugins; [ vim-sneak lazygit-nvim nvim-surround ];

  plugins = {
    cmp_luasnip.enable = true;
    which-key.enable = true;
    comment.enable = true;
    better-escape.enable = true;
    better-escape.mapping = [ "jk" ];
    lastplace.enable = true;
    diffview.enable = true;

    alpha = {
      enable = true;
      theme = "dashboard";
      iconsEnabled = true;
    };

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
      settings.signs = {
        add.text = "+";
        change.text = "~";
        delete.text = "_";
        topdelete.text = "‾";
        changedelete.text = "~";
      };
    };
    indent-blankline = {
      enable = true;
      settings.scope = {
        enabled = true;
        highlight = [ "@function" "@label" "@keyword" "@module" ];
      };
    };
    toggleterm = {
      enable = true;
      settings = {
        openMapping = "<c-s-t>tt";
        shadeTerminals = false;
      };
    };
    oil = {
      enable = true;
      settings.skipConfirmForSimpleEdits = true;
    };
    mini = {
      enable = true;
      modules = {
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
          paths = ./snippets;
        }
      ];
    };

    # deps
    fidget.enable = true;
    # nvim-web-devicons.enable = true;
    # neodiv.enable = true;
  } // import
    ./lsp
  // import
    ./treesitter
  // import
    ./lualine.nix
  // import
    ./harpoon.nix;
}
