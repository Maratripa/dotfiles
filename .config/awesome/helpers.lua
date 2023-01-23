local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local dpi = beautiful.xresources.apply_dpi

local helpers = {}

helpers.get_colorized_markup = function(content, fg)
    fg = fg or beautiful.colors.lavender
    content = content or ""

    return "<span foreground=\"" .. fg .. "\">" .. content .. "</span>"
end

helpers.capitalize = function(content)
    return string.upper(string.sub(content, 1, 1))
        .. string.sub(content, 2, #content)
end

helpers.trim = function(content)
    local result = content:gsub("%s+", "")
    return string.gsub(result, "%s+", "")
end

helpers.add_hover = function(element, bg, hbg)
    element:connect_signal("mouse::enter", function(self)
        self.bg = hbg
    end)
    element:connect_signal("mouse::leave", function(self)
        self.bg = bg
    end)
end

helpers.mkroundedrect = function(radius)
    radius = radius or dpi(10)
    return function(cr, w, h)
        return gears.shape.rounded_rect(cr, w, h, radius)
    end
end

helpers.mkbtn = function(template, bg, hbg, radius)
    local button = wibox.widget {
        {
            template,
            widget = wibox.container.margin,
        },
        bg = bg,
        widget = wibox.container.background,
        shape = helpers.mkroundedrect(radius),
    }

    if bg and hbg then
        helpers.add_hover(button, bg, hbg)
    end

    return button
end

helpers.toggle_kb_layout = function()
    awful.spawn.easy_async_with_shell("setxkbmap -print | grep 'us'", function(stdout)
        local layout = ""
        if stdout == "" then
            awful.spawn.with_shell("setxkbmap us")
            layout = "us"
        else
            awful.spawn.with_shell("setxkbmap latam")
            layout = "latam"
        end
        naughty.notification {
            title = "Layout changed to " .. layout,
            timeout = 1
        }

    end)
end

return helpers
