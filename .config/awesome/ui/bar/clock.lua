local wibox = require("wibox")
local beautiful = require("beautiful")

local dpi = beautiful.xresources.apply_dpi

-- local textdate = wibox.widget.textclock(
--     '<span font="Iosevka Bold 12">%d-%m-%Y</span>')

local textclock = wibox.widget.textclock(
    '<span font="Iosevka Bold 16">%H:%M</span>')

return wibox.widget {
    {
        textclock,
        valign = "center",
        fg = beautiful.fg_normal,
        spacing = dpi(4),
        widget = wibox.container.background,
    },
    right = dpi(7),
    left = dpi(7),
    widget = wibox.container.margin,
}
