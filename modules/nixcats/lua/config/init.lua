require("config.options")
require("config.keymaps")
require("plugins")

local colorschemeName = nixCats("colorscheme")
if not require("nixCatsUtils").isNixCats then
	colorschemeName = "yorumi"
end
vim.cmd.colorscheme(colorschemeName)
