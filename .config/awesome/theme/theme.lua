local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local colors = require("theme.catppuccin")

local themes_path = "~/.config/awesome/theme/"

local theme = {}

-- Fonts
theme.font = "Iosevka Regular 9"
theme.titlefont = "Iosevka Bold 9"
theme.fontname = "Iosevka"

-- Colors
theme.bg_normal = colors.bg_normal
theme.bg_focus = theme.bg_normal
theme.bg_urgent = colors.bg_light
theme.bg_minimize = colors.bg_dark
theme.bg_systray = theme.bg_normal
theme.bg_light = colors.bg_light
theme.bg_very_light = colors.bg_very_light
theme.bg_dark = colors.bg_dark

theme.fg_normal = colors.fg_normal
theme.fg_dark = colors.fg_dark
theme.fg_very_dark = colors.fg_very_dark
theme.fg_focus = theme.fg_normal
theme.fg_urgent = theme.fg_normal
theme.fg_minimize = theme.fg_normal

theme.highlight = colors.blue_alt
theme.highlight_alt = colors.green
theme.urgent = colors.red
theme.warning = colors.yellow

theme.blue = colors.blue
theme.blue_alt = colors.blue_alt
theme.cyan = colors.cyan
theme.cyan_alt = colors.cyan_alt
theme.green = colors.green
theme.green_alt = colors.green_alt
theme.purple = colors.purple
theme.purple_alt = colors.purple_alt
theme.red = colors.red
theme.red_alt = colors.reda_alt
theme.yellow = colors.yellow
theme.yellow_alt = colors.yellow_alt

-- Taglist
theme.taglist_bg = theme.bg_normal
theme.taglist_fg = theme.bg_light
theme.taglist_fg_focus = theme.highlight
theme.taglist_fg_occupied = theme.fg_normal

-- Gaps and borders
theme.useless_gap = dpi(5)
theme.border_width = dpi(1)
theme.border_normal = theme.bg_normal
theme.border_focus = theme.bg_very_light
theme.border_marked = theme.bg_light
theme.rounded_corners = true
theme.border_radius = dpi(8)

-- bar config
theme.bar_position = "top"
theme.bar_height = dpi(35)

-- wallpaper
theme.wallpaper = themes_path .. "wallpaper.jpg"
theme.wallpaper_blur = themes_path .. "wallpaper_blur.jpg"

return theme
