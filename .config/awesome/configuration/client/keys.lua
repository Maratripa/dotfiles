local awful = require('awful')
local gears = require('gears')
require("awful.autofocus")

local mod = require("configuration.keys.mod").modKey
local shift = "Shift"
local control = "Control"

-- Clientkeys
return gears.table.join(
    -- Fullscreen, floating and max
    awful.key({mod}, "f", function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "Toggle fullscreen", group = "client"}),
    
    awful.key({mod, control}, "space", awful.client.floating.toggle,
        {description = "Toggle floating", group = "client"}),
    
    awful.key({mod}, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(Un)maximize", group = "client"}),

    -- Utils
    awful.key({mod}, "q", function (c) c:kill() end,
        {description = "Close", group = "client"}),

    awful.key({mod}, "o", function (c) c:move_to_screen() end,
        {description = "Move to screen", group = "client"})
)