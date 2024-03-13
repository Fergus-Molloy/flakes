{ pkgs, ... }: {
  # Import all your configuration modules here
  imports = [
    ./options.nix
    ./globals.nix
    ./plugins
    ./keymaps
  ];
  extraConfigLua = ''
    if(vim.g.colors_name == "base16-gruvbox-material-dark-soft") then
      vim.api.nvim_set_hl(0, "@variable", {fg="#ebdbb2"})
      vim.api.nvim_set_hl(0, "@operator", {fg="#e78a4e"})
      vim.api.nvim_set_hl(0, "@comment", {fg="#bd6f3e"})
      vim.api.nvim_set_hl(0, "@punctuation.delimiter", {fg="#7c6f64"})
    end
    -- [[ Highlight on yank ]]
    local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
    vim.api.nvim_create_autocmd('TextYankPost', {
      callback = function()
        vim.highlight.on_yank()
      end,
      group = highlight_group,
      pattern = '*',
    })
  '';
}
