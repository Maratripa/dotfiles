local beautiful = require("beautiful")
local wibox = require("wibox")

local dpi = require('beautiful').xresources.apply_dpi

local systray = wibox.widget.systray()
systray:set_horizontal(true)
systray:set_base_size(32)

local TopPanel = function (s, offset)
    local offsetx = 0
    if offset == true then
        offsetx = dpi(128)
        offsety = dpi(6)
    end
    local panel = wibox({
        ontop = false,
        screen = s,
        height = dpi(36),
        width = dpi(128),
        x = s.geometry.x + s.geometry.width - dpi(318),
        y = s.geometry.y + offsety,
        stretch = false,
        bg = beautiful.bg.base,
        fg = beautiful.fg_normal,
        struts = {top = dpi(36)}
    })

    panel:setup{
        layout = wibox.layout.align.horizontal,
        wibox.container.margin(systray, dpi(4), dpi(4), dpi(4), dpi(4)),
        require("widget.battery")(),
        -- require('widget.battery')
    }

    return panel
end

return TopPanel