---@diagnostic disable: undefined-global
local awful = require 'awful'
local wibox = require 'wibox'
local gears = require 'gears'
local beautiful = require 'beautiful'
local helpers = require 'helpers'

local dpi = beautiful.xresources.apply_dpi

local username = wibox.widget {
    merkup = "...",
    align = "center",
    font = beautiful.font_name .. " 20",
    widget = wibox.widget.textbox,
}

awful.spawn.easy_async_with_shell("whoami", function(whoami)
    username:set_markup_silently("Hey " ..
        helpers.get_colorized_markup(helpers.capitalize(
            helpers.trim(whoami)
        ), beautiful.colors.blue_alt)
        .. '!')
end)

awesome.connect_signal("powermenu::toggle", function()
    local screen = awful.screen.focused()
    local powermenu = screen.powermenu
    powermenu.toggle()
end)

awesome.connect_signal("powermenu::visibility", function(v)
    local screen = awful.screen.focused()
    local powermenu = screen.powermenu
    if v then
        powermenu.show()
    else
        powermenu.hide()
    end
end)

local function make_powerbutton(opts)
    local default_widget = function(size, align)
        return wibox.widget {
            image = beautiful.icons .. "power/shutdown.svg",
            align = align,
            forced_height = size,
            forced_width = size,
            widget = wibox.widget.imagebox,
        }
    end

    if not opts then
        opts = {
            widget = default_widget,
            onclick = function() end,
            bg = beautiful.bg_normal,
        }
    end

    -- @DEFALT_VALUE -> key = 'bg'
    opts.bg = opts.bg and opts.bg or beautiful.bg_normal

    local call_widget = function()
        local icon_size = dpi(60)
        local align = "center"

        if opts.widget ~= nil then
            return opts.widget(icon_size, align)
        else
            return default_widget(icon_size, align)
        end
    end

    local button = wibox.widget {
        {
            call_widget(),
            top = dpi(2),
            bottom = dpi(2),
            left = dpi(18),
            right = dpi(18),
            widget = wibox.container.margin,
        },
        widget = wibox.container.background,
        bg = opts.bg,
        shape = gears.shape.circle,
    }

    -- add hover suppoert just when background is surface0
    if opts.bg == beautiful.bg_normal then
        helpers.add_hover(button, beautiful.bg_normal, "#181825")
    end

    button:add_button(awful.button({}, 1, function()
        if opts.onclick then
            opts.onclick()
        end
    end))

    return button
end

local powerbuttons = wibox.widget {
    make_powerbutton {
        widget = function(size, align)
            return wibox.widget {
                {
                    {
                        image = beautiful.icons .. "power/shutdown.svg",
                        forced_height = size,
                        forced_width = size,
                        align = align,
                        widget = wibox.widget.imagebox,
                    },
                    margins = dpi(4),
                    widget = wibox.container.margin,
                },
                fg = beautiful.colors.red,
                widget = wibox.container.background,
            }
        end,
        onclick = function()
            awful.spawn.with_shell("poweroff")
        end,
    },
    make_powerbutton {
        widget = function(size, align)
            return wibox.widget {
                {
                    {
                        image = beautiful.icons .. "power/reboot.svg",
                        align = align,
                        forced_height = size,
                        forced_width = size,
                        widget = wibox.widget.imagebox,
                    },
                    margins = dpi(4),
                    widget = wibox.container.margin,
                },
                fg = beautiful.colors.yellow,
                widget = wibox.container.background,
            }
        end,
        onclick = function()
            awful.spawn.with_shell("reboot")
        end
    },
    make_powerbutton {
        widget = function(size, align)
            return wibox.widget {
                {
                    {
                        image = beautiful.icons .. "power/logout.svg",
                        align = align,
                        forced_height = size,
                        forced_width = size,
                        widget = wibox.widget.imagebox,
                    },
                    margins = dpi(4),
                    widget = wibox.container.margin,
                },
                fg = beautiful.colors.purple,
                widget = wibox.container.background,
            }
        end,
        onclick = function()
            awful.spawn.with_shell("pkill awesome")
        end
    },
    make_powerbutton {
        widget = function(size, align)
            return wibox.widget {
                {
                    {
                        image = beautiful.icons .. "power/close.svg",
                        align = align,
                        forced_height = size,
                        forced_width = size,
                        widget = wibox.widget.imagebox,
                    },
                    margins = dpi(4),
                    widget = wibox.container.margin,
                },
                fg = beautiful.colors.blue,
                widget = wibox.container.background,
            }
        end,
        onclick = function()
            awesome.emit_signal("powermenu::visibility", false)
        end
    },
    spacing = dpi(18),
    layout = wibox.layout.fixed.horizontal,
}

awful.screen.connect_for_each_screen(function(s)
    s.powermenu = {}

    s.powermenu.widget = wibox.widget {
        {
            {
                markup = '',
                widget = wibox.widget.textbox,
            },
            bg = '#000000',
            widget = wibox.container.background,
            opacity = 0.12
        },
        {
            {
                {
                    {
                        {
                            image = beautiful.pfp,
                            forced_height = 128,
                            forced_width = 128,
                            halign = "center",
                            clip_shape = gears.shape.circle,
                            widget = wibox.widget.imagebox,
                        },
                        {
                            username,
                            {
                                markup = "What do you want to do?",
                                align = "center",
                                widget = wibox.widget.textbox,
                            },
                            spacing = dpi(2),
                            layout = wibox.layout.fixed.vertical,
                        },
                        {
                            powerbuttons,
                            widget = wibox.container.margin,
                            top = dpi(10),
                        },
                        spacing = dpi(7),
                        layout = wibox.layout.fixed.vertical,
                    },
                    margins = dpi(12),
                    widget = wibox.container.margin,
                },
                fg = beautiful.fg_normal,
                shape = helpers.mkroundedrect(),
                widget = wibox.container.background,
            },
            halign = "center",
            valign = "center",
            widget = wibox.container.margin,
            layout = wibox.container.place,
        },
        layout = wibox.layout.stack,
    }

    s.powermenu.spalsh = wibox {
        widget = s.powermenu.widget,
        screen = s,
        type = "splash",
        visible = false,
        ontop = true,
        bg = beautiful.bg_normal .. "80",
        height = s.geometry.height,
        width = s.geometry.width,
        x = s.geometry.x,
        y = s.geometry.y,
    }

    local self = s.powermenu.spalsh

    function s.powermenu.toggle()
        if self.visible then
            s.powermenu.hide()
        else
            s.powermenu.show()
        end
    end

    function s.powermenu.show()
        self.visible = true
    end

    function s.powermenu.hide()
        self.visible = false
    end
end)
