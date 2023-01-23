local wezterm = require("wezterm")

local function window_padding(margins)
	return {
		top = margins,
		bottom = margins,
		right = margins,
		left = margins
	}
end

return {
    -- Appearance
    font = wezterm.font "JetBrains Mono",
    line_height = 1.1,
    enable_tab_bar = false,
    color_scheme = "Catppuccin Mocha",
    window_padding = window_padding(20),

    -- Scrollback
    scrollback_lines = 3500,
}
