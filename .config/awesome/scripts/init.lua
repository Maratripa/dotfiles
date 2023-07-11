local awful = require("awful")
local gfs = require("gears.filesystem")

local path = gfs.get_configuration_dir() .. "scripts/"

return {
    screenshot = path .. "screenshot.sh",
    exe_xrandr = path .. "xrandr",
}
