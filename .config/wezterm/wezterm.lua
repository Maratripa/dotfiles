local wezterm = require('wezterm')

local function window_padding(margins)
	return {
		top = margins,
		bottom = margins,
		right = margins,
		left = margins
	}
end

local scheme = wezterm.get_builtin_color_schemes()['Catppuccin Mocha']
scheme.background = '#11111b'

return {
	-- OpenGl for GPU acceleration, Software for CPU
	front_end = 'OpenGL',
	-- Appearance
	enable_tab_bar = false,
	window_padding = window_padding(20),

	color_schemes = {
		['Catppuccin Mocha'] = scheme,
	},
	color_scheme = 'Catppuccin Mocha',

	-- Font
	font = wezterm.font 'JetBrains Mono',
	font_size = 11,
	line_height = 1.1,
	dpi = 96.0,

	-- Scrollback
	scrollback_lines = 3500,

	-- enable_wayland = false,
}
