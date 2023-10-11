local keymaps = require("config.keymaps")
return {
	{
		"frabjous/knap",
		enabled = false,
		keys = keymaps.knap,
		ft = { "tex", "markdown" },
	},
}
