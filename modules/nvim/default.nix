{
  # Import all your configuration modules here
  imports = [
    ./options.nix
    ./globals.nix
    ./plugins
    ./keymaps
  ];
  extraConfigLua = ''
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
