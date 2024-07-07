local plugins = {
	"Comment",
	"ibl",
	"which-key",
}

for _, plugin in ipairs(plugins) do
	require(plugin).setup()
end

require("plugins.treesitter")
require("plugins.conform")
require("plugins.fzf")
