local wezterm = require('wezterm')

local function window_padding(margins)
    return {
        top = margins,
        bottom = margins,
        right = margins,
        left = margins,
    }
end

local scheme = wezterm.get_builtin_color_schemes()['Catppuccin Mocha']
scheme.background = '#11111b'

return {
    -- Disable tab bar
    enable_tab_bar = false,
    window_padding = window_padding(20),
    color_schemes = {
        ['Catppuccin Mocha'] = scheme,
    },
    color_scheme = 'Catppuccin Mocha',
    -- Fonts
    font = wezterm.font_with_fallback { 'JetBrainsMono Nerd Font', 'JetBrains Mono', 'Symbols Nerd Font',
        'Noto Color Emoji', 'Phosphor-Fill', },
    font_size = 11,
    line_height = 1.1,
    dpi = 96.0,
    --Scrollback
    scrollback_lines = 3500,

    window_close_confirmation = 'NeverPrompt',
}
