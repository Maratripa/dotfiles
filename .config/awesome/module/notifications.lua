local naughty = require("naughty")
-- local beautiful = require("beautiful")
-- local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

-- Naughty presets
naughty.config.padding = 8
naughty.config.spacing = 8

naughty.config.defaults.timeout = 5
naughty.config.defaults.screen = _G.screen.primary
naughty.config.defaults.position = "top_right"
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.ontop = true
-- naughty.config.defaults.font = beautiful.font
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = dpi(40)
-- naughty.config.defaults.shape = gears.shape.rectangle
naughty.config.defaults.border_width = 0
-- naughty.config.defaults.hover_timeout = nil

-- Error handling
if _G.awesome.startup_errors then
    naughty.notification {
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = _G.awesome.startup_errors
    }
end

do
    local in_error = false
    _G.awesome.connect_signal(
        "debug::error",
        function (err)
            if in_error then
                return
            end
            in_error = true

            naughty.notification {
                preset = naughty.config.presets.critical,
                title = "Oops, an error happened!",
                text = tostring(err)
            }
            in_error = false
        end
    )
end

_G.log_this = function (title, txt)
    naughty.notification {
        title = "log: " .. title,
        text = txt
    }
end
