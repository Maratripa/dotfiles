local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi

-- Clock / Calendar 24h format
local textclock = wibox.widget.textclock(
    "<span font='Iosevka SS14 Bold 12'>%H:%M</span>")

local clock_widget = wibox.container.margin(textclock, dpi(8), dpi(8), dpi(8), dpi(8))

local ClockPanel = function (s, offset)
    -- local offsety = dpi(12)
    local panel = wibox {
        ontop = false,
        screen = s,
        height = dpi(36),
        width = dpi(56),
        x = s.geometry.x + s.geometry.width - dpi(184),
        y = s.geometry.y + offsety,
        stretch = false,
        bg = beautiful.bg.base,
        fg = beautiful.fg_normal,
        struts = {top = dpi(36)}
    }

    panel:setup {layout = wibox.layout.fixed.horizontal, clock_widget}

    return panel
end

return ClockPanel