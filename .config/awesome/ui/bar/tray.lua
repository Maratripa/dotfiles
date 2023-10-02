---@diagnostic disable: undefined-global
local wibox = require 'wibox'
local awful = require 'awful'
local beautiful = require 'beautiful'
local gears = require 'gears'

local dpi = beautiful.xresources.apply_dpi

local function get_tray()
    return awful.screen.focused().tray
end

awesome.connect_signal("tray::toggle", function()
    if awful.screen.focused().tray then
        get_tray().toggle()
    end
end)

awesome.connect_signal("tray::visibility", function(v)
    if v then
        get_tray().show()
    else
        get_tray().hide()
    end
end)

awful.screen.connect_for_each_screen(function(s)
    if s ~= screen.primary then
        return
    end

    s.tray = {}

    s.tray.widget = wibox.widget {
        {
            {
                {
                    widget = wibox.widget.systray,
                    horizontal = true,
                    screen = s,
                    base_size = dpi(28),
                },
                layout = wibox.layout.fixed.horizontal,
            },
            margins = dpi(12),
            widget = wibox.container.margin,
        },
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal,
        widget = wibox.container.background,
        shape = gears.shape.rounded_rect
    }

    s.tray.popup = awful.popup {
        widget = s.tray.widget,
        screen = s,
        visible = false,
        ontop = true,
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal,
        minimum_width = dpi(200),
        minimum_height = dpi(150),
        shape = gears.shape.rounded_rect,
        placement = function(d)
            return awful.placement.top_right(d, {
                margins = {
                    right = dpi(200),
                    top = dpi(54),
                }
            })
        end,
    }

    local self, tray = s.tray.popup, s.tray

    function tray.toggle()
        if self.visible then
            tray.hide()
        else
            tray.show()
        end
    end

    function tray.show()
        self.visible = true
    end

    function tray.hide()
        self.visible = false
    end
end)
