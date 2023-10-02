local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

-- Naughty presets
naughty.config.padding = dpi(10)
naughty.config.spacing = dpi(4)

naughty.config.defaults.margin = dpi(10)
naughty.config.defaults.border_width = 0
naughty.config.defaults.max_width = dpi(350)
naughty.config.defaults.icon_size = 32
-- naughty.config.defaults.shape = function(cr, w, h)
-- gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
-- end
naughty.config.defaults.screen = _G.screen.primary

-- naughty.config.defaults.position = "top_right"
-- naughty.config.defaults.ontop = true
-- naughty.config.defaults.font = beautiful.font
-- naughty.config.defaults.hover_timeout = nil

naughty.config.presets.low.timeout = 5
naughty.config.presets.normal.timeout = 6
naughty.config.presets.critical.timeout = 12
