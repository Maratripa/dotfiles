local awful = require("awful")
local gears = require("gears")

local mod = require("configuration.keys.mod").modKey

return gears.table.join(
    awful.button({}, 1, function (c)
        _G.client.focus = c
        c:raise()
    end),
    awful.button({mod}, 1, awful.mouse.client.move),
    awful.button({mod}, 3, awful.mouse.client.resize),
    awful.button({mod}, 4, function () awful.layout.inc(1) end),
    awful.button({mod}, 5, function () awful.layout.inc(-1) end)
)