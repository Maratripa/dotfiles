local awful = require('awful')
local gears = require('gears')
require("awful.autofocus")

local mod = require("configuration.keys.mod").modKey
local shift = "Shift"
local control = "Control"

-- Clientkeys
return gears.table.join(
    -- Fullscreen and floating
    awful.key({mod}, "f", function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "Toggle fullscreen", group = "client"}),
    -- Utils
    awful.key({mod}, "q", function (c) c:kill() end,
        {description = "Close", group = "client"}),
    awful.key({mod}, "o", function (c) c:move_to_screen() end,
        {description = "Move to screen", group = "client"})
)