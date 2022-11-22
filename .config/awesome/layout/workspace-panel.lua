local beautiful = require("beautiful")
local wibox = require("wibox")
local TagList = require("widget.tag-list")

local dpi = require('beautiful').xresources.apply_dpi

local WorkspacePanel = function (s, offset)
    local offsetx = 0
    if offset == true then
        offsetx = dpi(50)
        offsety = dpi(6)
    end
    local panel = wibox({
        ontop = false,
        screen = s,
        height = dpi(36),
        width = dpi(200),
        x = s.geometry.x + offsetx,
        y = s.geometry.y + offsety,
        stretch = false,
        bg = beautiful.bg.base,
        fg = beautiful.fg_normal,
        struts = {top = dpi(36)}
    })

    panel:struts {
        top = dpi(44)
    }

    panel:setup{layout = wibox.layout.align.horizontal, TagList(s)}

    return panel
end

return WorkspacePanel