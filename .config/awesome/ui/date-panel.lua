local beautiful = require('beautiful')
local wibox = require('wibox')

local dpi = require('beautiful').xresources.apply_dpi

local textclock = wibox.widget.textclock(
                      '<span font="Iosevka SS14 Bold 12">%d.%m.%Y\n     %H:%M</span>')

local date_widget = wibox.container.margin(textclock, dpi(8), dpi(8), dpi(8),
                                           dpi(8))

local DatePanel = function(s, offset)
    -- local offsety = dpi(12)
    local panel = wibox({
        ontop = false,
        screen = s,
        height = dpi(36),
        width = dpi(96),
        x = s.geometry.x + s.geometry.width - dpi(128),
        y = s.geometry.y + offsety,
        stretch = false,
        bg = beautiful.bg.base,
        fg = beautiful.fg_normal,
        struts = {top = dpi(36)}
    })

    panel:setup{layout = wibox.layout.fixed.horizontal, date_widget}

    return panel
end

return DatePanel
