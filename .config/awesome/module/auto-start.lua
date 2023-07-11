-- runs configuration/autostart.sh

local awful = require("awful")
local gfs = require("gears.filesystem")

local sh_path = gfs.get_configuration_dir() .. "configuration/autostart.sh"

local function load_autostart()
    awful.spawn("bash " .. sh_path)
end

load_autostart()
