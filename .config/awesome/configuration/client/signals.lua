local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

-- Signal function to execute when a new client appears.
_G.client.connect_signal(
    "manage",
    function(c)
        if _G.awesome.startup and not c.size_hints.user_position and
            not c.size_program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end

        -- rounded corners
        c.shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
        end
    end
)

_G.client.connect_signal(
    "mouse::enter",
    function(c)
        c:emit_signal("request::activate", "mouse_enter", { raise = false })
    end
)

_G.client.connect_signal(
    "focus",
    function(c)
        c.border_color = beautiful.border_focus
    end
)

_G.client.connect_signal(
    "unfocus",
    function(c)
        c.border_color = beautiful.border_normal
    end
)
