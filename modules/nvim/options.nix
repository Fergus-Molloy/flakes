{
  config.options = {
    # search options
    hlsearch = true;
    ignorecase = true;
    smartcase = true;
    gdefault = true;
    # line numbers
    number = true;
    relativenumber = true;

    # enable mouse
    mouse = "a";

    # don't sync OS clipboard with Neovim.
    clipboard = "";
    breakindent = false; # maybe change to true?

    # tabs and spaces
    joinspaces = false;
    expandtab = true;
    shiftwidth = 2;
    tabstop = 2;

    # use undo file
    undofile = true;

    # always show sign column
    signcolumn = "yes";

    # decrease update time
    updatetime = 250;
    timeoutlen = 300;

    # better completion selection
    completeopt = "menuone,noselect";

    # Font
    termguicolors = true;
    guifont = "Fira Code:h16";

    # better cursor visibility
    cursorline = true;
    colorcolumn = "80";
    scrolloff = 8;
    sidescrolloff = 8;
  };
}
