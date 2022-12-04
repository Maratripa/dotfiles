local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")

-- Theme
beautiful.init(require("theme"))

-- Layout
require("ui")

-- Init all modules
require("module.notifications")
require("module.set-wallpaper")
require("module.auto-start")

-- Setup all configurations
require("configuration.client")
require("configuration.tags")
_G.root.keys(require("configuration.keys.global"))


-- Garbage collection
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)