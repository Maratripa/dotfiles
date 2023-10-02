---@diagnostic disable: undefined-global
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local helpers = require("helpers")

local dpi = beautiful.xresources.apply_dpi

local battery_widget = require("widget.battery")
local wifi_widget = require("widget.wifi")
local volume_widget = require("widget.volume")
local clock_widget = require("ui.bar.clock")
local get_tags = require("ui.tags")
local keyboard_widget = require('ui.bar.keyboardlayout')

require("ui.bar.tray")
require("ui.bar.calendar")
require("ui.powermenu")

screen.connect_signal("request::desktop_decoration", function(s)
    local taglist = get_tags(s)

    local tray_dispatcher = helpers.mkbtn({
        image = beautiful.icons .. 'tray/down.svg',
        forced_height = 20,
        forced_width = 20,
        valign = 'center',
        halign = 'center',
        widget = wibox.widget.imagebox,
    }, beautiful.bg_normal, "#181825")

    tray_dispatcher:add_button(awful.button({}, 1, function()
        awesome.emit_signal("tray::toggle")
    end))

    if not s.tray then
        tray_dispatcher.visible = false
    end

    local menubutton = helpers.mkbtn({
        {
            {
                volume_widget,
                wifi_widget,
                battery_widget,
                spacing = dpi(14),
                layout = wibox.layout.fixed.horizontal,
            },
            top = dpi(6),
            bottom = dpi(6),
            left = dpi(10),
            right = dpi(10),
            widget = wibox.container.margin
        },
        bg = "#313244",
        fg = beautiful.fg_normal,
        widget = wibox.container.background,
        shape = helpers.mkroundedrect(15),
    }, "#313244", "#1e1e2e", dpi(15))

    -- menubutton:add_button(awful.button({}, 1, function()
    -- end))

    local powerbutton = helpers.mkbtn({
        image = beautiful.icons .. "power/shutdown.svg",
        forced_height = dpi(40),
        forced_width = dpi(32),
        halign = "center",
        valign = "center",
        widget = wibox.widget.imagebox,
    }, beautiful.bg_normal, "#181825")

    powerbutton:add_button(awful.button({}, 1, function()
        awesome.emit_signal("powermenu::toggle")
    end))

    local clockbutton = helpers.mkbtn(clock_widget, beautiful.bg_normal, "#181825")

    clockbutton:add_button(awful.button({}, 1, function()
        awesome.emit_signal("calendar::toggle")
    end))

    s.mywibox = awful.wibar {
        position = "top",
        screen = s,
        width = s.geometry.width - dpi(20),
        height = dpi(50),
        shape = gears.shape.rectangle,
        margins = {
            top = dpi(10),
            left = dpi(10),
            right = dpi(10),
        },
    }
    s.mywibox:setup {
        {
            {
                {
                    taglist,
                    widget = wibox.container.margin,
                    left = dpi(15),
                },
                layout = wibox.layout.fixed.horizontal,
            },
            {
                {
                    clockbutton,
                    valign = 'center',
                    widget = wibox.container.place,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            {
                {
                    tray_dispatcher,
                    right = dpi(5),
                    top = dpi(12),
                    bottom = dpi(12),
                    widget = wibox.container.margin,
                },
                {
                    keyboard_widget(),
                    valign = 'center',
                    widget = wibox.container.place,
                },
                {
                    {
                        menubutton,
                        valign = 'center',
                        widget = wibox.container.place,
                    },
                    right = dpi(12),
                    widget = wibox.container.margin,
                },
                spacing = dpi(8),
                layout = wibox.layout.fixed.horizontal,
            },
            layout = wibox.layout.align.horizontal,
            expand = 'none',
        },
        widget = wibox.container.background,
        bg = beautiful.bg_normal,
        forced_height = s.mywibox.height,
    }

    s.mywibox:struts {
        top = s.mywibox.height + dpi(10),
    }
end)
