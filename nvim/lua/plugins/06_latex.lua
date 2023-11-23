local keymaps = require("config.keymaps")
return {
	{
		"frabjous/knap",
		enabled = true,
		keys = keymaps.knap,
		ft = { "tex", "markdown" },
	},
}
