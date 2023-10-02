---@diagnostic disable: undefined-global
local wibox = require 'wibox'
local awful = require 'awful'
local beautiful = require 'beautiful'
-- local gears = require 'gears'
local helpers = require 'helpers'

local dpi = beautiful.xresources.apply_dpi

local function get_menu()
    return awful.screen.focused().menu
end

awesome.connect_signal('menu::toggle', function()
    if awful.screen.focused().menu then
        get_menu().toggle()
    end
end)

awesome.connect_signal('menu::visibility', function(v)
    if v then
        get_menu().show()
    else
        get_menu().hide()
    end
end)

awful.screen.connect_for_each_screen(function(s)
    s.menu = {}

    s.menu.widget = wibox.widget {
        {
            {
                {
                    image = beautiful.icons .. 'volume/speaker_high.svg',
                    forced_height = 24,
                    forced_width = 24,
                    valign = 'center',
                    halign = 'center',
                    widget = wibox.widget.imagebox,
                },
                {
                    image = beautiful.icons .. 'wifi/wifi_medium.svg',
                    forced_height = 24,
                    forced_width = 24,
                    valign = 'center',
                    halign = 'center',
                    widget = wibox.widget.imagebox,
                },
                {
                    image = beautiful.icons .. 'battery/battery-full-symbolic.svg',
                    forced_height = 24,
                    forced_width = 24,
                    valign = 'center',
                    halign = 'center',
                    widget = wibox.widget.imagebox,
                },
                layout = wibox.layout.horizontal,
            },
            margins = dpi(10),
            widget = wibox.container.margin,
        },
        bg = "#313244",
        fg = beautiful.fg_normal,
        widget = wibox.container.background,
        shape = helpers.mkroundedrect(15),
    }
end)
