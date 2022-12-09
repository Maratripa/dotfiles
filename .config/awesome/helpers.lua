local awful = require("awful")
local naughty = require("naughty")

local helpers = {}

helpers.toggle_kb_layout = function ()
    awful.spawn.easy_async_with_shell ("setxkbmap -print | grep 'us'", function (stdout)
        local layout = ""
        if stdout == "" then
            awful.spawn.with_shell("setxkbmap us")
            layout = "us"
        else
            awful.spawn.with_shell("setxkbmap latam")
            layout = "latam"
        end
        naughty.notification{
            title = "Layout changed to " .. layout,
            timeout = 1
        }

    end)
end

return helpers